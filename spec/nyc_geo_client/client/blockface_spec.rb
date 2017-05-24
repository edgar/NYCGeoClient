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
          @client.blockface(
            on_street: '34 st',
            cross_street_one: 'fifth ave',
            cross_street_two: 'sixth ave',
            borough: 'manhattan',
            compass_direction: 'north'
          )

          expect(a_get("blockface.#{format}").
            with(query: {
              app_id:  @client.app_id,
              app_key: @client.app_key,
              onStreet: '34 st',
              crossStreetOne: 'fifth ave',
              crossStreetTwo: 'sixth ave',
              borough: 'manhattan',
              compassDirection: 'north'
            })).to have_been_made
        end

        it "should return the blockface info" do
          data = @client.blockface(
            on_street: '34 st',
            cross_street_one: 'fifth ave',
            cross_street_two: 'sixth ave',
            borough: 'manhattan',
            compass_direction: 'north'
          )

          expect(data.keys).to eq ["blockface"]
        end
      end
    end
  end
end
