module Redbooth
  class Client < API::Client
    def initialize(options = {})
      @options = {:url => "https://redbooth.com/api/3/"}.merge(options)

      @conn = Faraday.new(url: @options[:url]) do |conn|
        conn.adapter :net_http

        conn.request :json
        conn.authorization :Bearer, @options[:token]

        conn.response :logger if Rails.env.development?
        conn.response :json, :content_type => /\bjson$/

        conn.use Faraday::Response::RaiseError
      end
    end

    def post(path, data = {})
      @conn.post do |req|
        req.url path
        req.headers['Content-Type'] = 'application/json'
        req.body = data
      end.body
    end
  end
end