# NYCGeoClient [![Build Status](https://app.travis-ci.com/edgar/NYCGeoClient.svg?branch=master)](https://app.travis-ci.com/edgar/NYCGeoClient) [![Gem Version](https://badge.fury.io/rb/nyc_geo_client.svg)](http://badge.fury.io/rb/nyc_geo_client)
A ruby gem for the NYC GeoClient API - https://api-portal.nyc.gov/docs/services/geoclient/operations/geoclient

## Installation

Add this line to your application's Gemfile:

    gem 'nyc_geo_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nyc_geo_client


*NOTE:* You will need to register an application with the [NYC API Portal](https://api-portal.nyc.gov/), and make sure that you check off access to the Geoclient API for the application. Take note of the Application's subscription key.

## API Usage Examples

    require "rubygems"
    require "nyc_geo_client"

    client = NYCGeoClient::Client.new(subscription_key: 'KEY')

    # get block and property level information about an address
    client.address(house_number: '13', street: 'crosby', borough: 'manhattan')

    # property level information about a tax lot
    client.bbl(borough: 'manhattan', block: '00233', lot: '0004')

    # get property level information about a building
    client.bin(bin: '1003041')

    # get information about a segment defined by an on street between two cross-streets
    client.blockface(
        on_street: '34 st',
        cross_street_one: 'fifth ave',
        cross_street_two: 'sixth ave',
        borough: 'manhattan'
    )

    # get information about a point defined by two cross streets
    client.intersection(
        cross_street_one: '34 st',
        cross_street_two: 'fifth ave',
        borough: 'manhattan'
    )

    # get address information using a well-known place name
    client.place(name: 'empire state building', borough: 'manhattan')


For more information about the data returned by every method please check the specs folder

## Configuration

Because NYCGeoClient gem is based on [Faraday](https://github.com/lostisland/faraday), it supports the following adapters:

* Net::HTTP (default)
* [Excon](https://github.com/geemus/excon)
* [Typhoeus](https://github.com/typhoeus/typhoeus)
* [Patron](http://toland.github.com/patron/)
* [EventMachine](https://github.com/igrigorik/em-http-request)

Beside the adapter, you can change the following properties:

* endpoint
* format
* user_agent
* proxy
* debug

For instance:

    require 'typhoeus/adapters/faraday' # You will need the typhoeus gem

    client = NYCGeoClient.client(adapter: :typhoeus, user_agent: "foobar v1", debug: true, app_id: 'foo', app_key: 'bar')
    client.address(house_number: '13', street: 'crosby', borough: 'manhattan')

## Ruby versions supported

* 2.4
* 2.5
* 2.6
* 2.7

Check the [.travis.yml](.travis.yml) to see the current supported ruby versions.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
