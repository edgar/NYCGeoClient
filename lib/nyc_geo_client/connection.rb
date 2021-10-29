require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module NYCGeoClient
  # @private
  module Connection
    private

    def connection(raw=false)
      options = {
        headers: {
          'Accept' => "application/json; charset=utf-8",
          'User-Agent' => user_agent,
          'Ocp-Apim-Subscription-Key' => subscription_key
        },
        proxy: proxy,
        ssl: {verify: false},
        url: endpoint
      }

      Faraday::Connection.new(options) do |connection|
        connection.use Faraday::Request::UrlEncoded
        unless raw
          connection.use FaradayMiddleware::Mashify
          connection.use Faraday::Response::ParseJson if format == :json
          connection.use Faraday::Response::ParseXml if format == :xml
        end
        connection.use FaradayMiddleware::RaiseHttpException
        connection.use Faraday::Response::Logger if debug
        connection.adapter(adapter)
      end
    end
  end
end
