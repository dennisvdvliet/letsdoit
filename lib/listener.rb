class Listener
  def self.call
    unless File.split($0).last == 'rake'
      require 'tweetstream'
      puts "Starting twitter"
      TweetStream.configure do |config|
        config.consumer_key       = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret    = ENV["TWITTER_CONSUMER_SECRET"]
        config.oauth_token        = ENV["TWITTER_OAUTH_TOKEN"]
        config.oauth_token_secret = ENV["TWITTER_OATUH_SECRET"]
        config.auth_method        = :oauth
      end
      @client = TweetStream::Client.new

      Thread.new do
        @client.on_limit do |skip_count|
          Rails.logger.error "Twitter: Hitting limit skipping #{skip_count} events"
        end

        @client.on_enhance_your_calm do |message|
          Rails.logger.error "Twitter: Keep calm and continue waitinga"
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

        @client.track("#dtv") do |status, client|
          Rails.logger.info "Twitter: We received a new tweet"
          User.active.each do |user|
            TaskFromTweet.call(user, status)
          end
        end
        ActiveRecord::Base.connection.close
      end
    end
  end
end