module NYCGeoClient
  class Client
    # Defines methods related to branches
    module Blockface

      # Returns information about a segment defined by an on street between two cross-streets.
      #
      # @param on_street [String] The street on which the segment is found
      # @param cross_street_one [String] The first cross street
      # @param cross_street_two [String] The second cross street
      # @param borough [String] The borough in which the on_street is located
      # @param extra [Hash] optional params:
      #   - boroughCrossStreetOne: The borough in which the cross_street_one is located if it differs from the borough parameter
      #   - boroughCrossStreetTwo: The borough in which the cross_street_two is located if it differs from the borough parameter
      #   - compassDirection: Used when requesting information about only one side of the street (north, south, west, east, n, s, w, e)
      # @return [Hashie::Mash]
      # @example information about a segment defined by an on street between two cross-streets
      #   NYCGeoClient.blockface('34 st', 'fifht ave', 'sixth ave', 'manhattan')
      # @format :json, :xml
      def blockface(on_street:, cross_street_one:, cross_street_two:, borough:, borough_cross_street_one: nil, borough_cross_street_two: nil, compass_direction: nil)
        options = {
          onStreet:    on_street,
          crossStreetOne: cross_street_one,
          crossStreetTwo: cross_street_two,
          borough: borough,
          boroughCrossStreetOne: borough_cross_street_one,
          boroughCrossStreetTwo: borough_cross_street_two,
          compassDirection: compass_direction
        }.reject { |k, v| v.nil? }
        get(blockface_path, options)
      end

      protected

      def blockface_path
        "blockface"
      end
    end
  end
end