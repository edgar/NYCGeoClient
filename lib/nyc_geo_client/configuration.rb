require 'faraday'
require File.expand_path('../version', __FILE__)

module NYCGeoClient
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {NYCGeoClient::API}
    VALID_OPTIONS_KEYS = [
      :adapter,
      :app_id,
      :app_key,
      :endpoint,
      :format,
      :user_agent,
      :proxy,
      :debug
    ].freeze

    # An array of valid request/response formats
    VALID_FORMATS = [:json, :xml].freeze

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default, don't set an application ID
    DEFAULT_APP_ID = nil

    # By default, don't set an application KEY
    DEFAULT_APP_KEY = nil

    # The endpoint that will be used to connect if none is set
    #
    # @note There is no reason to use any other endpoint at this time
    DEFAULT_ENDPOINT = 'https://api.cityofnewyork.us/geoclient/v1/'.freeze

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    # @note JSON and XML are the available formats
    DEFAULT_FORMAT = :json

    # By default, don't use a proxy server
    DEFAULT_PROXY = nil

    # By default, dont' log the request/response
    DEFAULT_DEBUG = false

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "NYCGeoClient #{NYCGeoClient::VERSION}".freeze

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.adapter        = DEFAULT_ADAPTER
      self.app_id         = DEFAULT_APP_ID
      self.app_key        = DEFAULT_APP_KEY
      self.endpoint       = DEFAULT_ENDPOINT
      self.format         = DEFAULT_FORMAT
      self.user_agent     = DEFAULT_USER_AGENT
      self.proxy          = DEFAULT_PROXY
      self.debug          = DEFAULT_DEBUG
    end
  end
end