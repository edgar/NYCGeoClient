require File.expand_path('../../../spec_helper', __FILE__)

describe NYCGeoClient::Client do

  NYCGeoClient::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do

      before do
        @client = NYCGeoClient::Client.new(app_id: 'ID', app_key: 'KEY', format: format)
      end

      describe ".intersection" do
        before do
          stub_get("intersection.#{format}").
            with(
              query: {
                app_id:  @client.app_id,
                app_key: @client.app_key,
                crossStreetOne: '34 st',
                crossStreetTwo: 'fifth ave',
                borough: 'manhattan',
                compassDirection: 'north'
              }).
            to_return(body: fixture("intersection.#{format}"), headers: {content_type: "application/#{format}; charset=utf-8"})
        end

        it "should get the correct resource" do
          @client.intersection('34 st', 'fifth ave', 'manhattan', {compassDirection: 'north'})
          a_get("intersection.#{format}").
            with(query: {
              app_id:  @client.app_id,
              app_key: @client.app_key,
              crossStreetOne: '34 st',
              crossStreetTwo: 'fifth ave',
              borough: 'manhattan',
              compassDirection: 'north'
            }).should have_been_made
        end

        it "should return the intersection info" do
          data = @client.intersection('34 st', 'fifth ave', 'manhattan', {compassDirection: 'north'})
          data.keys.should be == ["intersection"]
        end
      end
    end
  end
end
