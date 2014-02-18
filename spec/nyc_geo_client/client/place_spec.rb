require File.expand_path('../../../spec_helper', __FILE__)

describe NYCGeoClient::Client do

  NYCGeoClient::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do

      before do
        @client = NYCGeoClient::Client.new(app_id: 'ID', app_key: 'KEY', format: format)
      end

      describe ".place" do
        before do
          stub_get("place.#{format}").
            with(
              query: {
                app_id:  @client.app_id,
                app_key: @client.app_key,
                name:    'empire state building',
                borough: 'manhattan'
              }).
            to_return(body: fixture("place.#{format}"), headers: {content_type: "application/#{format}; charset=utf-8"})
        end

        it "should get the correct resource" do
          @client.place('empire state building', 'manhattan')
          a_get("place.#{format}").
            with(query: {
              app_id:  @client.app_id,
              app_key: @client.app_key,
              name:    'empire state building',
              borough: 'manhattan'
            }).should have_been_made
        end

        it "should return the place info" do
          data = @client.place('empire state building', 'manhattan')
          data.keys.should be == ["place"]
        end
      end
    end
  end
end
