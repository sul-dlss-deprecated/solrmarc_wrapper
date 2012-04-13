require 'rspec/core/rake_task'

namespace :solrmarc_wrapper do

  RSpec::Core::RakeTask.new(:rspec) do |spec|
    spec.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  end

end
