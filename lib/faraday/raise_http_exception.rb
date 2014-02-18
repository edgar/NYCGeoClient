require 'faraday'

# @private
module FaradayMiddleware
  # @private
  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        if [403, 500, 503].include? response[:status].to_i
          raise NYCGeoClient::Error.new(error_message(response), response[:status].to_i)
        end
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end

    private

    def error_message(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{[response[:status].to_s, response[:body]].compact.join(': ')}"
    end
  end
end