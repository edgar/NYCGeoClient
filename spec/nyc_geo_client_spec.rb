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
      NYCGeoClient.address('13', 'crosby', 'manhattan')
      a_get("address.json").
        with(query: {
          houseNumber: '13',
          street: 'crosby',
          borough: 'manhattan'
        }).should have_been_made
    end

     it "should return the same results as a client" do
       NYCGeoClient.address('13', 'crosby', 'manhattan').should == NYCGeoClient::Client.new.address('13', 'crosby', 'manhattan')
     end

   end

  describe ".client" do
    it "should be a NYCGeoClient::Client" do
      NYCGeoClient.client.should be_a NYCGeoClient::Client
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      NYCGeoClient.adapter.should == NYCGeoClient::Configuration::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      NYCGeoClient.adapter = :typhoeus
      NYCGeoClient.adapter.should == :typhoeus
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      NYCGeoClient.endpoint.should == NYCGeoClient::Configuration::DEFAULT_ENDPOINT
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      NYCGeoClient.endpoint = 'http://tumblr.com'
      NYCGeoClient.endpoint.should == 'http://tumblr.com'
    end
  end

  describe ".format" do
    it "should return the default format" do
      NYCGeoClient.format.should == NYCGeoClient::Configuration::DEFAULT_FORMAT
    end
  end

  describe ".format=" do
    it "should set the format" do
      NYCGeoClient.format = 'xml'
      NYCGeoClient.format.should == 'xml'
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      NYCGeoClient.user_agent.should == NYCGeoClient::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      NYCGeoClient.user_agent = 'Custom User Agent'
      NYCGeoClient.user_agent.should == 'Custom User Agent'
    end
  end

  describe ".configure" do

    NYCGeoClient::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        NYCGeoClient.configure do |config|
          config.send("#{key}=", key)
          NYCGeoClient.send(key).should == key
        end
      end
    end
  end

end