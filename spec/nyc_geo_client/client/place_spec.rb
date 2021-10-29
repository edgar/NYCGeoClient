require File.expand_path('../../../spec_helper', __FILE__)

describe NYCGeoClient::Client do

  NYCGeoClient::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do

      before do
        @client = NYCGeoClient::Client.new(subscription_key: 'KEY', format: format)
      end

      describe ".place" do
        context 'given a borough' do
          before do
            stub_get("place.#{format}").
              with(
                query: {
                  name:    'empire state building',
                  borough: 'manhattan'
                }).
              to_return(body: fixture("place.#{format}"), headers: {content_type: "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.place(name: 'empire state building', borough: 'manhattan')
            expect(a_get("place.#{format}").
              with(query: {
                name:    'empire state building',
                borough: 'manhattan'
              })).to have_been_made
          end

          it "should return the place info" do
            data = @client.place(name: 'empire state building', borough: 'manhattan')
            expect(data.keys).to eq ["place"]
          end
        end

        context 'given a zip' do
          before do
            stub_get("place.#{format}").
              with(
                query: {
                  name: 'empire state building',
                  zip: '10118'
                }).
              to_return(body: fixture("place.#{format}"), headers: {content_type: "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.place(name: 'empire state building', zip: '10118')
            expect(a_get("place.#{format}").
              with(query: {
                name: 'empire state building',
                zip: '10118'
              })).to have_been_made
          end

          it "should return the place info" do
            data = @client.place(name: 'empire state building', zip: '10118')
            expect(data.keys).to eq ["place"]
          end
        end
      end
    end
  end
end
