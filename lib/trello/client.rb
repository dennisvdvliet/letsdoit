module Trello
  class Client < API::Client
    def initialize(options = {})
      @options = {:url => "https://api.trello.com/1/"}.merge(options)

      @conn = Faraday.new(url: @options[:url]) do |conn|
        conn.adapter :net_http
        conn.request :url_encoded

        conn.response :logger if Rails.env.development?
        conn.response :json, :content_type => /\bjson$/

        conn.use Faraday::Response::RaiseError
      end
    end

    def get(path, data = {})
      @conn.get(path, data.merge(auth_params)).body
    end

    def post(path, data = {})
      @conn.post do |req|
        req.url path
        req.body = data.merge(auth_params).to_query
      end.body
    end

    private
      def auth_params
        {:key => ENV["TRELLO_APP_ID"], :token => @options[:token]}
      end
  end
end