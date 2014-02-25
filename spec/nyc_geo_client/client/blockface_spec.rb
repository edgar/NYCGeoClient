require File.expand_path('../../../spec_helper', __FILE__)

describe NYCGeoClient::Client do

  NYCGeoClient::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do

      before do
        @client = NYCGeoClient::Client.new(app_id: 'ID', app_key: 'KEY', format: format)
      end

      describe ".blockface" do
        before do
          stub_get("blockface.#{format}").
            with(
              query: {
                app_id:  @client.app_id,
                app_key: @client.app_key,
                onStreet: '34 st',
                crossStreetOne: 'fifth ave',
                crossStreetTwo: 'sixth ave',
                borough: 'manhattan',
                compassDirection: 'north'
              }).
            to_return(body: fixture("blockface.#{format}"), headers: {content_type: "application/#{format}; charset=utf-8"})
        end

        it "should get the correct resource" do
          @client.blockface('34 st', 'fifth ave', 'sixth ave', 'manhattan', {compassDirection: 'north'})
          a_get("blockface.#{format}").
            with(query: {
              app_id:  @client.app_id,
              app_key: @client.app_key,
              onStreet: '34 st',
              crossStreetOne: 'fifth ave',
              crossStreetTwo: 'sixth ave',
              borough: 'manhattan',
              compassDirection: 'north'
            }).should have_been_made
        end

        it "should return the blockface info" do
          data = @client.blockface('34 st', 'fifth ave', 'sixth ave', 'manhattan', {compassDirection: 'north'})
          data.keys.should be == ["blockface"]
        end
      end
    end
  end
end
