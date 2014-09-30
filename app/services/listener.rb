class Listener
  def self.call
    Rails.logger.error "Starting twitter listener #{Rails.env}"
    TweetStream.configure do |config|
      config.consumer_key       = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret    = ENV["TWITTER_CONSUMER_SECRET"]
      config.oauth_token        = ENV["TWITTER_OAUTH_TOKEN"]
      config.oauth_token_secret = ENV["TWITTER_OAUTH_SECRET"]
      config.auth_method        = :oauth
    end
    @client = TweetStream::Client.new
    @client.on_limit do |skip_count|
      Rails.logger.error "Twitter: Hitting limit skipping #{skip_count} events"
    end

    @client.on_enhance_your_calm do |message|
      Rails.logger.error "Twitter: Keep calm and continue waiting"
    end

    @client.on_error do |message|
      Rails.logger.error "Twitter: We found an error: #{message}"
    end

    @client.on_stall_warning do |message|
      Rails.logger.error "Twitter: We stalled"
    end

    @client.on_unauthorized do |message|
      Rails.logger.error "Twitter: Not authorized!"
    end

    @client.track(ENV["LISTEN_TO"]) do |status, client|
      Rails.logger.error "Twitter: We received a new tweet #{status.text}"
      User.active.each do |user|
        TaskFromTweet.call(user, status)
      end
    end
  end
end