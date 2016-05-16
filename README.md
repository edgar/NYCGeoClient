# NYCGeoClient [![Build Status](https://travis-ci.org/edgar/NYCGeoClient.png?branch=master)](https://travis-ci.org/edgar/NYCGeoClient)
A ruby gem for the NYC GeoClient API - https://developer.cityofnewyork.us/api/geoclient-api

## Installation

Add this line to your application's Gemfile:

    gem 'nyc_geo_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nyc_geo_client


*NOTE:* You will need to register an application with the [NYC Developer Portal](https://developer.cityofnewyork.us/), and make sure that you check off access to the Geoclient API for the application. Take note of the Application's ID and key.

## API Usage Examples

    require "rubygems"
    require "nyc_geo_client"

    client = NYCGeoClient::Client.new(app_id: 'ID', app_key: 'KEY')

    # get block and property level information about an address
    client.address('13', 'crosby', 'manhattan')

    # property level information about a tax lot
    client.bbl('manhattan', '00233', '0004')

    # get property level information about a building
    client.bin('1003041')

    # get information about a segment defined by an on street between two cross-streets
    client.blockface('34 st', 'fifth ave', 'sixth ave', 'manhattan')

    # get information about a point defined by two cross streets
    client.intersection('34 st', 'fifth ave', 'manhattan')

    # get address information using a well-known place name
    client.place('empire state building', 'manhattan')


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
    client.address('13','crosby','manhattan')


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
