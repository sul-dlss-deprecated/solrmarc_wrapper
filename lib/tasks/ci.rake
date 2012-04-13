desc "run continuous integration suite (tests, coverage, docs)" 

namespace :solrmarc_wrapper do

  task :ci do 
    Rake::Task["rspec"].invoke
    Rake::Task["doc"].invoke
  end

end
