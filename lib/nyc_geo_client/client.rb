module NYCGeoClient
  class Client < API

    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    include NYCGeoClient::Client::Address
    include NYCGeoClient::Client::BBL
    include NYCGeoClient::Client::BIN
  end
end