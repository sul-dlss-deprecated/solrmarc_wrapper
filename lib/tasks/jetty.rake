##For jettywrapper set the app_ROOT
APP_ROOT= File.expand_path(File.join(File.dirname(__FILE__),".."))
require 'jettywrapper'

namespace :sm_wrap do
  namespace :jetty do
    
    desc "Copies the Solr configs into the submodule test-jetty instance"
    task :config do
      dev_dir = "test-jetty/solr/dev/conf"
      test_dir = "test-jetty/solr/test/conf"
      mkdir_p(dev_dir) unless Dir.exists?(dev_dir)
      mkdir_p(test_dir) unless Dir.exists?(test_dir)
      cp('spec/solr/solr.xml', 'test-jetty/solr/', :verbose => true)
      source_dir = "solrmarc/stanford-sw/solr/conf"
      cp("#{source_dir}/schema.xml", dev_dir, :verbose => true)
      cp("#{source_dir}/schema.xml", test_dir, :verbose => true)
      cp("#{source_dir}/solrconfig-no-repl.xml", "#{dev_dir}/solrconfig.xml", :verbose => true)
      cp("#{source_dir}/solrconfig-no-repl.xml", "#{test_dir}/solrconfig.xml", :verbose => true)
      cp("#{source_dir}/stopwords_punctuation.txt", dev_dir, :verbose => true)
      cp("#{source_dir}/stopwords_punctuation.txt", test_dir, :verbose => true)
    end

    desc "Copies the SOLR config files and starts up the test-jetty instance"
    task :load => [:config, 'jetty:start']

  end
end