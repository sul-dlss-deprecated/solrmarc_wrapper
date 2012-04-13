##For jettywrapper set the app_ROOT
APP_ROOT= File.expand_path(File.join(File.dirname(__FILE__),".."))
require 'jettywrapper'

namespace :sm_wrap do
  namespace :jetty do
    
    desc "Copies the Solr configs into the submodule test-jetty instance"
    task :config do
      cp('spec/solr/solr.xml' 'test-jetty/solr/', :verbose => true)
      cp('solrmarc/stanford-sw/solr/conf/schema.xml' 'test-jetty/solr/dev/conf/', :verbose => true)
      cp('solrmarc/stanford-sw/solr/conf/schema.xml' 'test-jetty/solr/test/conf/', :verbose => true)
      cp('solrmarc/stanford-sw/solr/conf/solrconfig-no-repl.xml' 'test-jetty/solr/dev/conf/solrconfig.xml', :verbose => true)
      cp('solrmarc/stanford-sw/solr/conf/solrconfig-no-repl.xml' 'test-jetty/solr/test/conf/solrconfig.xml', :verbose => true)
      cp('solrmarc/stanford-sw/solr/conf/stopwords_punctuation.txt' 'test-jetty/solr/dev/conf/', :verbose => true)
      cp('solrmarc/stanford-sw/solr/conf/stopwords_punctuation.txt' 'test-jetty/solr/test/conf/', :verbose => true)
    end

    desc "Copies the SOLR config files and starts up the test-jetty instance"
    task :load => [:config, 'jetty:start']

  end
end