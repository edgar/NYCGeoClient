require File.expand_path('../../../spec_helper', __FILE__)

describe NYCGeoClient::Client do

  NYCGeoClient::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do

      before do
        @client = NYCGeoClient::Client.new(app_id: 'ID', app_key: 'KEY', format: format)
      end

      describe ".bin" do
        before do
          stub_get("bin.#{format}").
            with(
              query: {
                app_id:  @client.app_id,
                app_key: @client.app_key,
                bin:     '1003041',
              }).
            to_return(body: fixture("bin.#{format}"), headers: {content_type: "application/#{format}; charset=utf-8"})
        end

        it "should get the correct resource" do
          @client.bin('1003041')
          expect(a_get("bin.#{format}").
            with(query: {
              app_id:  @client.app_id,
              app_key: @client.app_key,
              bin:     '1003041',
            })).to have_been_made
        end

        it "should return the bin info" do
          data = @client.bin('1003041')
          expect(data.keys).to eq ["bin"]
        end
      end
    end
  end
end
