namespace :sm_wrap do
  namespace :solrmarc do
    require 'ant'
    
    desc "run ant dist_site target in solrmarc"
    task :ant_dist_site do
      ant '-f solrmarc/build.xml dist_site'
    end

  end
end