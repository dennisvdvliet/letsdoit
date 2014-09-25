# unless File.split($0).last == 'rake'
#   puts "Doing twitter"
#   require 'tweetstream'
#   TweetStream.configure do |config|
#     config.consumer_key       = ENV["TWITTER_CONSUMER_KEY"]
#     config.consumer_secret    = ENV["TWITTER_CONSUMER_SECRET"]
#     config.oauth_token        = ENV["TWITTER_OAUTH_TOKEN"]
#     config.oauth_token_secret = ENV["TWITTER_OATUH_SECRET"]
#     config.auth_method        = :oauth
#   end
#   Thread.new do
#     puts "Awesome"
#     TweetStream::Client.new.on_error{|message| puts message}.sample{|status| puts "#{Time.now} - #{status.text}"}
# #    TweetStream::Client.new.on_error{|message| puts message}.track("justin"){|status| puts "#{Time.now} - #{status.text}"}
#   end
# end