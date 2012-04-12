require File.expand_path('../spec_helper', __FILE__)
require "solrmarc_wrapper"
require 'logger'

describe SolrmarcWrapper do
  
  before(:all) do
    @solrmarc_wrapper = SolrmarcWrapper.new(@@settings.solrmarc_dist_dir, @@settings.solrmarc_conf_props_file, @@settings.solr_url)
  end
  
  it "should retrieve the SolrInputDoc generated from the marc record" do
    sid = @solrmarc_wrapper.get_solr_input_doc_from_marcxml("666")
    sid.should be_an_instance_of(Java::OrgApacheSolrCommon::SolrInputDocument)
    sid["id"].getValue.should == "666"
    sid["title_full_display"].getValue.should_not be_nil
  end
  
  it "should have a SolrInputDoc with the non-stored fields present" do
    sid = @solrmarc_wrapper.get_solr_input_doc_from_marcxml("666")
    sid["title_245a_search"].getValue.should_not be_nil
  end
  
  it "should log an error message when there is no document in the Solr index for the ckey" do
    lager = double("logger")
    @solrmarc_wrapper.logger = lager
    lager.should_receive(:error).with("Can't find single SearchWorks Solr document with id aaa")
    @solrmarc_wrapper.get_solr_input_doc_from_marcxml("aaa")
  end
  
end
