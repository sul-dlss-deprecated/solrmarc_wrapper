# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "solrmarc_wrapper/version"

Gem::Specification.new do |gem|
  gem.name          = "solrmarc_wrapper"
  gem.version       = SolrmarcWrapper::VERSION
  gem.authors       = ["Naomi Dushay"]
  gem.email         = ["ndushay@stanford.edu"]
  gem.summary       = "Ruby wrapper for accessing SolrMarc methods"
  gem.description   = "Contains SolrMarc instance and ruby code to use methods of interest"
  gem.requirements  = "This gem must be run under JRuby, and also requires a solrmarc dist directory and solr url (see settings.yml)"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

  # No Runtime dependencies

  # Bundler will install these gems too if you've checked out solrmarc-wrapper source from git and run 'bundle install'
  # It will not add these as dependencies if you require solrmarc-wrapper for other projects
  gem.add_development_dependency "rake"
  # docs
  gem.add_development_dependency "rdoc"
  gem.add_development_dependency "yard"
  # tests
	gem.add_development_dependency 'rspec'
	gem.add_development_dependency 'simplecov'
	gem.add_development_dependency 'simplecov-rcov'

end
