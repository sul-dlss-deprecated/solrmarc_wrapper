require 'rspec/core/rake_task'

namespace :sm_wrap do

  desc "Run all specs, with jetty instance running"
  task :rspec_wrapped do
#  task :rspec_wrapped => ['sm_wrap:jetty:config_ci', 'sm_wrap:solrmarc:ant_dist_site'] do
    test_jetty_dir = File.expand_path(File.dirname(__FILE__) + '../../../solrmarc/test/jetty')
    require 'jettywrapper'
    jetty_params = Jettywrapper.load_config.merge({
      :jetty_home => test_jetty_dir,
      :solr_home => test_jetty_dir + '/solr',
      :java_opts => "-Dsolr.data.dir=" + test_jetty_dir + "/solr/test/data",
      :jetty_port => 8983,
      :startup_wait => 25
    })
    error = Jettywrapper.wrap(jetty_params) do 
      `sh ./spec/scripts/curl_empty_test_solr.sh`
      `sh ./spec/scripts/curl_add_bare666_to_test.sh`
      Rake::Task['sm_wrap:rspec_core'].invoke
    end
    raise "TEST FAILURES: #{error}" if error
  end

  RSpec::Core::RakeTask.new(:rspec_core) do |spec|
    spec.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  end

end
