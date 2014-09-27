namespace :twitter do
  desc 'Listen to streaming Twitter API'
  task :listen => :environment do
    Listener.call
  end
end