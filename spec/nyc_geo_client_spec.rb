require 'spec_helper'

describe NYCGeoClient do
  after do
    NYCGeoClient.reset
  end

  context "when delegating to a client" do

     before do
      stub_get("address.json").
        with(
          query: {
            houseNumber: '13',
            street: 'crosby',
            borough: 'manhattan'
          }).
        to_return(body: fixture("address.json"), headers: {content_type: "application/json; charset=utf-8"})
      end

    it "should get the correct resource" do
      NYCGeoClient.address(house_number: '13', street: 'crosby', borough: 'manhattan')
      expect(a_get("address.json").
        with(query: {
          houseNumber: '13',
          street: 'crosby',
          borough: 'manhattan'
        })).to have_been_made
    end

     it "should return the same results as a client" do
      expect(
        NYCGeoClient.address(
          house_number: '13',
          street: 'crosby',
          borough: 'manhattan'
        )
      ).to eq NYCGeoClient::Client.new.address(
        house_number: '13',
        street: 'crosby',
        borough: 'manhattan'
      )
     end

   end

  describe ".client" do
    it "should be a NYCGeoClient::Client" do
      expect(NYCGeoClient.client).to be_a NYCGeoClient::Client
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      expect(NYCGeoClient.adapter).to eq NYCGeoClient::Configuration::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      NYCGeoClient.adapter = :typhoeus
      expect(NYCGeoClient.adapter).to eq :typhoeus
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      expect(NYCGeoClient.endpoint).to eq NYCGeoClient::Configuration::DEFAULT_ENDPOINT
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      NYCGeoClient.endpoint = 'http://tumblr.com'
      expect(NYCGeoClient.endpoint).to eq 'http://tumblr.com'
    end
  end

  describe ".format" do
    it "should return the default format" do
      expect(NYCGeoClient.format).to eq NYCGeoClient::Configuration::DEFAULT_FORMAT
    end
  end

  describe ".format=" do
    it "should set the format" do
      NYCGeoClient.format = 'xml'
      expect(NYCGeoClient.format).to eq 'xml'
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      expect(NYCGeoClient.user_agent).to eq NYCGeoClient::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      NYCGeoClient.user_agent = 'Custom User Agent'
      expect(NYCGeoClient.user_agent).to eq 'Custom User Agent'
    end
  end

  describe ".configure" do

    NYCGeoClient::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        NYCGeoClient.configure do |config|
          config.send("#{key}=", key)
          expect(NYCGeoClient.send(key)).to eq key
        end
      end
    end
  end

end