require File.expand_path('../../spec_helper', __FILE__)

describe NYCGeoClient::API do
  before do
    @keys = NYCGeoClient::Configuration::VALID_OPTIONS_KEYS
  end

  context "with module configuration" do

    before do
      NYCGeoClient.configure do |config|
        @keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      NYCGeoClient.reset
    end

    it "should inherit module configuration" do
      api = NYCGeoClient::API.new
      @keys.each do |key|
        expect(api.send(key)).to eq key
      end
    end

    context "with class configuration" do

      before do
        @configuration = {
          :app_id => 'ID',
          :app_key => 'KEY',
          :adapter => :typhoeus,
          :endpoint => 'http://tumblr.com/',
          :format => :xml,
          :proxy => 'http://shayne:sekret@proxy.example.com:8080',
          :user_agent => 'Custom User Agent',
          :debug => true
        }
      end

      context "during initialization"

        it "should override module configuration" do
          api = NYCGeoClient::API.new(@configuration)
          @keys.each do |key|
            expect(api.send(key)).to eq @configuration[key]
          end
        end

      context "after initilization" do

        it "should override module configuration after initialization" do
          api = NYCGeoClient::API.new
          @configuration.each do |key, value|
            api.send("#{key}=", value)
          end
          @keys.each do |key|
            expect(api.send(key)).to eq @configuration[key]
          end
        end
      end
    end
  end
end