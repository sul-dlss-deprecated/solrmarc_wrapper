include Java

require "solrmarc_wrapper/version"
require 'logger'

# a way to use SolrMarc objects, 
#  such as using SolrReIndexer to get a SolrInputDocument from a marc record stored in the Solr index.
class SolrmarcWrapper
  
  attr_accessor :logger

  # @param solrmarc_dist_dir  distribution directory of SolrMarc build 
  # @param solrmarc_conf_props_fname  the name of the xx_config.properties file for SolrMarc, relative to solrmarc_dist_dir
  # @param solr_url  the base url of a running Solr server 
  # @param log_level  level of Logger messages to output; defaults to Logger::INFO
  # @param log_file  file to receive Logger output; defaults to STDERR
  # solr_url  base url of the solr instance
  def initialize(solrmarc_dist_dir, config_props_fname, solr_url, log_level=Logger::INFO, log_file=STDERR)
    if not defined? JRUBY_VERSION
      raise "SolrmarcWrapper only runs under jruby"
    end
    @logger = Logger.new(log_file)
    @logger.level = log_level
    load_solrmarc(solrmarc_dist_dir)
    setup_solr_reindexer(solr_url, config_props_fname)
  end

  # retrieves the full marc rec
  # ord stored in the Solr index, runs it through SolrMarc indexing to get a SolrInputDocument 
  #  note that it identifies Solr documents by the "id" field, and expects the marc to be stored in a Solr field "marcxml"
  #  if there is no single document matching the id, an error is logged and nil is returned
  # @param doc_id  the value of the "id" Solr field for the record to be retrieved
  # @return a SolrInputDocument for the doc_id, populated via marcxml and SolrMarc
  def get_solr_input_doc_from_marcxml(doc_id)
    begin
      @solr_input_doc = @solrmarc_reindexer.getSolrInputDoc("id", doc_id, "marcxml")
    rescue java.lang.NullPointerException
      @logger.error("Can't find single Solr document with id #{doc_id}")
      return nil
    end
    @solr_input_doc
  end


protected

  # require all the necessary jars to use SolrMarc classes
  def load_solrmarc(solr_marc_dir)
    Dir["#{solr_marc_dir}/**/*.jar"].each {|jar_file| require jar_file }
  end

  # initialize the @solrmarc_reindexer object
  # @param solr_url the url of the Solr server
  # @param config_props_fname  the name of the xx_config.properties file relative to the solr_marc_dir used in initialize method
  def setup_solr_reindexer(solr_url, config_props_fname)
    solr_core_loader = org.solrmarc.solr.SolrCoreLoader.loadRemoteSolrServer(solr_url, false, false)
    @solrmarc_reindexer = org.solrmarc.marc.SolrReIndexer.new(solr_core_loader)
    @solrmarc_reindexer.init([config_props_fname])
  end
  
end # module SolrmarcWrapper