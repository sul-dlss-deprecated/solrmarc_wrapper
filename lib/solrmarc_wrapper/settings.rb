require 'yaml'

# Read the .yml file containing the configuration values
class Settings
  
  attr_reader :solrmarc_dist_dir, :solrmarc_conf_props_file, :solr_url
  
  def initialize(settings_group)
    yml = YAML.load_file('config/settings.yml')[settings_group]
    @solrmarc_dist_dir = yml["solrmarc_dist_dir"]
    @solrmarc_conf_props_file = yml["solrmarc_conf_props_file"]
    @solr_url = yml["solr_url"]
  end
  
  # @return the attributes of this class as a Hash
  def as_hash
    {:solrmarc_dist_dir => @solrmarc_dist_dir,
      :solrmarc_conf_props_file => @solrmarc_conf_props_file,
      :solr_url => @solr_url }
  end
  
end