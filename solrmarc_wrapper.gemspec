# -*- encoding: utf-8 -*-
require File.join(File.dirname(__FILE__), "lib/solrmarc_wrapper/version")

Gem::Specification.new do |gem|
  gem.name          = "solrmarc_wrapper"
  gem.version       = SolrmarcWrapper::VERSION
  gem.authors       = ["Naomi Dushay"]
  gem.email         = ["ndushay@stanford.edu"]
  gem.summary       = "Ruby wrapper for accessing SolrMarc objects and Solr objects"
  gem.description   = "Ruby wrapper for accessing SolrMarc objects and Solr objects, such as using org.solrmarc.marc.SolrReIndexer to get a SolrInputDocument from a marc record stored in the Solr index"
  gem.requirements  = "This gem must be run under JRuby, and also requires a solrmarc dist directory and solr url (see config/settings.yml)"

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
  gem.add_development_dependency "jettywrapper"

end
