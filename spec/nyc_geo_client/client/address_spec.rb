require File.expand_path('../../../spec_helper', __FILE__)

describe NYCGeoClient::Client do

  NYCGeoClient::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do

      before do
        @client = NYCGeoClient::Client.new(app_id: 'ID', app_key: 'KEY', format: format)
      end

      describe ".address" do
        before do
          stub_get("address.#{format}").
            with(
              query: {
                app_id: @client.app_id,
                app_key: @client.app_key,
                houseNumber: '13',
                street: 'crosby',
                borough: 'manhattan'
              }).
            to_return(body: fixture("address.#{format}"), headers: {content_type: "application/#{format}; charset=utf-8"})
        end

        it "should get the correct resource" do
          @client.address('13', 'crosby', 'manhattan')
          expect(a_get("address.#{format}").
            with(query: {
              app_id: @client.app_id,
              app_key: @client.app_key,
              houseNumber: '13',
              street: 'crosby',
              borough: 'manhattan'
            })).to have_been_made
        end

        it "should return the address info" do
          data = @client.address('13', 'crosby', 'manhattan')
          expect(data.keys).to eq ["address"]
        end
      end
    end
  end
end
