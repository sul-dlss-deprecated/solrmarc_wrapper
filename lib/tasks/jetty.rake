##For jettywrapper set the app_ROOT
APP_ROOT= File.expand_path(File.join(File.dirname(__FILE__),".."))
require 'jettywrapper'

namespace :sm_wrap do
  namespace :jetty do
    
    desc "Copy the Solr configs into the submodule test-jetty cores"
    task :config do
      dev_conf_dir = "test-jetty/solr/dev/conf"
      test_conf_dir = "test-jetty/solr/test/conf"

      mkdir_p(dev_conf_dir) unless Dir.exists?(dev_conf_dir)
      mkdir_p(test_conf_dir) unless Dir.exists?(test_conf_dir)

      cp('spec/solr/solr.xml', 'test-jetty/solr/', :verbose => true)

      Dir["test-jetty/solr/conf/**/*"].each { |f| 
        cp_r(f, dev_conf_dir, :verbose => true)
        cp_r(f, test_conf_dir, :verbose => true)
      }

      source_dir = "solrmarc/stanford-sw/solr/conf"
      cp("#{source_dir}/schema.xml", dev_conf_dir, :verbose => true)
      cp("#{source_dir}/schema.xml", test_conf_dir, :verbose => true)
      cp("#{source_dir}/solrconfig-no-repl.xml", "#{dev_conf_dir}/solrconfig.xml", :verbose => true)
      cp("#{source_dir}/solrconfig-no-repl.xml", "#{test_conf_dir}/solrconfig.xml", :verbose => true)
      cp("#{source_dir}/stopwords_punctuation.txt", dev_conf_dir, :verbose => true)
      cp("#{source_dir}/stopwords_punctuation.txt", test_conf_dir, :verbose => true)
    end

    desc "Copies the SOLR config files and starts up the test-jetty instance"
    task :load => [:config, 'jetty:start']

  end
end