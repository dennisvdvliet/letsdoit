module Redbooth
  class Client < API::Client
    def initialize(options = {})
      @options = {:url => "https://redbooth.com/api/3/"}.merge(options)

      @conn = Faraday.new(url: @options[:url]) do |conn|
        conn.adapter :net_http

        conn.request :url_encoded
        conn.authorization :Bearer, @options[:token]

        conn.response :logger if Rails.env.development?
        conn.response :json, :content_type => /\bjson$/

        conn.use Faraday::Response::RaiseError
      end
    end
  end
end