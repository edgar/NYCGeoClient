# NYCGeoClient [![Build Status](https://travis-ci.org/edgar/NYCGeoClient.png?branch=master)](https://travis-ci.org/edgar/NYCGeoClient)
A ruby gem for the NYC GeoClient API - https://developer.cityofnewyork.us/api/geoclient-api-beta

## Installation

Add this line to your application's Gemfile:

    gem 'nyc_geo_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nyc_geo_client

## API Usage Examples

    require "rubygems"
    require "nyc_geo_client"


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
