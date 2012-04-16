namespace :sm_wrap do

  desc "run continuous integration suite (tests, coverage, docs)" 
  task :ci do 
    Rake::Task["rspec_wrapped"].invoke
    Rake::Task["doc"].invoke
  end

end
