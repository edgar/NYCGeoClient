require File.expand_path('../nyc_geo_client/error', __FILE__)
require File.expand_path('../nyc_geo_client/configuration', __FILE__)
require File.expand_path('../nyc_geo_client/api', __FILE__)
require File.expand_path('../nyc_geo_client/client', __FILE__)

module NYCGeoClient
  extend Configuration

  # Alias for NYCGeoClient::Client.new
  #
  # @return [NYCGeoClient::Client]
  def self.client(options={})
    NYCGeoClient::Client.new(options)
  end

  # Delegate to NYCGeoClient::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to NYCGeoClient::Client
  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end
end
