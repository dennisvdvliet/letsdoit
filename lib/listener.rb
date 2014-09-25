class Listener
  def call
    unless File.split($0).last == 'rake'
      require 'tweetstream'
      TweetStream.configure do |config|
        config.consumer_key       = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret    = ENV["TWITTER_CONSUMER_SECRET"]
        config.oauth_token        = ENV["TWITTER_OAUTH_TOKEN"]
        config.oauth_token_secret = ENV["TWITTER_OATUH_SECRET"]
        config.auth_method        = :oauth
      end

      if defined?(@client) && @client
        @client.stop
      end
      @client = TweetStream::Client.new
      Thread.new do
        @client.track("justin") do |status|
          # save 
          puts "#{Time.now} - #{status.to_json}"
        end
      end
    end
  end
end