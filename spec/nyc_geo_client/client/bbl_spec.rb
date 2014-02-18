require File.expand_path('../../../spec_helper', __FILE__)

describe NYCGeoClient::Client do

  NYCGeoClient::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do

      before do
        @client = NYCGeoClient::Client.new(app_id: 'ID', app_key: 'KEY', format: format)
      end

      describe ".bbl" do
        before do
          stub_get("bbl.#{format}").
            with(
              query: {
                app_id:  @client.app_id,
                app_key: @client.app_key,
                borough: 'manhattan',
                block:   '00233',
                lot:     '0004',
              }).
            to_return(body: fixture("bbl.#{format}"), headers: {content_type: "application/#{format}; charset=utf-8"})
        end

        it "should get the correct resource" do
          @client.bbl('manhattan', '00233', '0004')
          a_get("bbl.#{format}").
            with(query: {
              app_id:  @client.app_id,
              app_key: @client.app_key,
              borough: 'manhattan',
              block:   '00233',
              lot:     '0004',
            }).should have_been_made
        end

        it "should return the bbl info" do
          data = @client.bbl('manhattan', '00233', '0004')
          data.keys.should be == ["bbl"]
        end
      end
    end
  end
end
