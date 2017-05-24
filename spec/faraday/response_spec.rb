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
        expect(lambda do
          @client.address(house_number: '13', street: 'crosby', borough: 'manhattan')
        end).to raise_error(NYCGeoClient::Error)
      end

      it "should return the status and body" do
        begin
          @client.address(house_number: '13', street: 'crosby', borough: 'manhattan')
        rescue NYCGeoClient::Error => ex
          expect(ex.status).to eq status
          parts = ex.message.split(": ")
          expect(parts[0]).to match /GET https:\/\/api.cityofnewyork.us\/geoclient\/v1\/address.json/
          expect(parts[1]).to eq "#{status}"
          expect(parts[2]).to eq "some message"
        end
      end
    end
  end
end
