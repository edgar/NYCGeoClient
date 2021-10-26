require File.expand_path('../../../spec_helper', __FILE__)

describe NYCGeoClient::Client do

  NYCGeoClient::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do

      before do
        @client = NYCGeoClient::Client.new(subscription_key: 'KEY', format: format)
      end

      describe ".intersection" do
        before do
          stub_get("intersection.#{format}").
            with(
              query: {
                crossStreetOne: '34 st',
                crossStreetTwo: 'fifth ave',
                borough: 'manhattan',
                compassDirection: 'north'
              }).
            to_return(body: fixture("intersection.#{format}"), headers: {content_type: "application/#{format}; charset=utf-8"})
        end

        it "should get the correct resource" do
          @client.intersection(
            cross_street_one: '34 st',
            cross_street_two: 'fifth ave',
            borough: 'manhattan',
            compass_direction: 'north'
          )

          expect(a_get("intersection.#{format}").
            with(query: {
              crossStreetOne: '34 st',
              crossStreetTwo: 'fifth ave',
              borough: 'manhattan',
              compassDirection: 'north'
            })).to have_been_made
        end

        it "should return the intersection info" do
          data = @client.intersection(
            cross_street_one: '34 st',
            cross_street_two: 'fifth ave',
            borough: 'manhattan',
            compass_direction: 'north'
          )

          expect(data.keys).to eq ["intersection"]
        end
      end
    end
  end
end
