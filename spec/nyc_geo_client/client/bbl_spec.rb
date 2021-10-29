require File.expand_path('../../../spec_helper', __FILE__)

describe NYCGeoClient::Client do

  NYCGeoClient::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do

      before do
        @client = NYCGeoClient::Client.new(subscription_key: 'KEY', format: format)
      end

      describe ".bbl" do
        before do
          stub_get("bbl.#{format}").
            with(
              query: {
                borough: 'manhattan',
                block:   '00233',
                lot:     '0004',
              }).
            to_return(body: fixture("bbl.#{format}"), headers: {content_type: "application/#{format}; charset=utf-8"})
        end

        it "should get the correct resource" do
          @client.bbl(borough: 'manhattan', block: '00233', lot: '0004')
          expect(a_get("bbl.#{format}").
            with(query: {
              borough: 'manhattan',
              block:   '00233',
              lot:     '0004',
            })).to have_been_made
        end

        it "should return the bbl info" do
          data = @client.bbl(borough: 'manhattan', block: '00233', lot: '0004')
          expect(data.keys).to eq ["bbl"]
        end
      end
    end
  end
end
