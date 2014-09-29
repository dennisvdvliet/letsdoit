namespace :twitter do
  desc 'Listen to streaming Twitter API'
  task :listen => :environment do
    puts "There we go"
    Rails.logger.error "Dd"
    puts Listener.call
  end
end