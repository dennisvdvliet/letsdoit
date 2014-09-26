module Trello
  class Client < API::Client
    def initialize(options = {})
      @options = {:url => "https://api.trello.com/1/"}.merge(options)

      @conn = Faraday.new(url: @options[:url]) do |conn|
        conn.adapter :net_http

        conn.response :logger if Rails.env.development?
        conn.response :json, :content_type => /\bjson$/

        conn.use Faraday::Response::RaiseError
      end
    end

    def get(path, data = {})
      @conn.get(path, data.merge(auth_params)).body
    end

    private
      def auth_params
        {:key => ENV["TRELLO_APP_ID"], :token => @options[:token]}
      end
  end
end