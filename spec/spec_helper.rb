require 'coveralls'
Coveralls.wear!

# for test coverage
require 'simplecov'
SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter "spec"
  add_filter "config"
end

require 'solrmarc_wrapper/settings'

$LOAD_PATH.unshift(File.dirname(__FILE__))

RSpec.configure do |config|
  # Set up the environment for testing and make all variables available to the specs
  settings_env = ENV["SETTINGS"] ||= 'dev'
  @@settings = Settings.new(settings_env)
end
