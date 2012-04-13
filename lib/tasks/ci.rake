desc "run continuous integration suite (tests, coverage, docs)" 

namespace :sm_wrap do

  task :ci do 
    Rake::Task["rspec"].invoke
    Rake::Task["doc"].invoke
  end

end
