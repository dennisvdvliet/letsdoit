namespace :twitter do
  desc 'Listen to streaming Twitter API'
  task :listen => :environment do
    TweetStream::Client.new.on_error{|message| puts message}.track("justin"){|status| Rails.logger.info status.text}
  end
end