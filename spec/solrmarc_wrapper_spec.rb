require File.expand_path('../spec_helper', __FILE__)
require "solrmarc_wrapper"
require 'logger'

describe SolrmarcWrapper do
  
  before(:all) do
    @solrmarc_wrapper = SolrmarcWrapper.new(@@settings.solrmarc_dist_dir, @@settings.solrmarc_conf_props_file, @@settings.solr_url)
  end
  
  it "retrieves the SolrInputDoc generated from the marc record" do
    sid = @solrmarc_wrapper.get_solr_input_doc_from_marcxml("666")
    expect(sid).to be_an_instance_of(Java::OrgApacheSolrCommon::SolrInputDocument)
    expect(sid["id"].getValue).to eq("666")
    expect(sid["title_full_display"].getValue).not_to be_nil
  end
  
  it "has a SolrInputDoc with the non-stored fields present" do
    sid = @solrmarc_wrapper.get_solr_input_doc_from_marcxml("666")
    expect(sid["title_245a_search"].getValue).not_to be_nil
  end
  
  it "logs an error message when there is no document in the Solr index for the ckey" do
    lager = double("logger")
    @solrmarc_wrapper.logger = lager
    expect(lager).to receive(:error).with("Can't find single Solr document with id aaa")
    @solrmarc_wrapper.get_solr_input_doc_from_marcxml("aaa")
  end
  
end
