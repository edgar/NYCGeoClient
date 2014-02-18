require File.expand_path('../../spec_helper', __FILE__)

describe Faraday::Response do
  before do
    @client = NYCGeoClient::Client.new(app_id: 'foo', app_key: 'bar')
  end

  [403, 500, 503].each do |status|
    context "when HTTP status is #{status}" do
      before do
        stub_get("address.json").
          with(
            query: {
              app_id: @client.app_id,
              app_key: @client.app_key,
              houseNumber: '13',
              street: 'crosby',
              borough: 'manhattan'
            }).
          to_return(body: 'some message', status: status)
      end

      it "should raise a NYCGeoClient error" do
        lambda do
          @client.address('13','crosby','manhattan')
        end.should raise_error(NYCGeoClient::Error)
      end

      it "should return the status and body" do
        begin
          @client.address('13','crosby','manhattan')
        rescue NYCGeoClient::Error => ex
          ex.status.should be == status
          ex.message.split(": ").should be == [
            "GET https://api.cityofnewyork.us/geoclient/v1/address.json?app_id=foo&app_key=bar&houseNumber=13&street=crosby&borough=manhattan",
            "#{status}",
            "some message"
          ]
        end
      end
    end
  end
end
