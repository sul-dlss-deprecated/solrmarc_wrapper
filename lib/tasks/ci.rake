namespace :sm_wrap do

  desc "run continuous integration suite (tests, coverage, docs)" 
  task :ci do 
    Rake::Task["sm_wrap:rspec_wrapped"].invoke
    Rake::Task["sm_wrap:doc"].invoke
  end

end
