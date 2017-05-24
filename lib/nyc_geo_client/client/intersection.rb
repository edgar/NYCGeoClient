module NYCGeoClient
  class Client
    # Defines methods related to branches
    module Intersection

      # Returns information about a point defined by two cross streets.
      #
      # @param cross_street_one [String] The first cross street
      # @param cross_street_two [String] The second cross street
      # @param borough [String] The borough in which the on_street is located
      # @param extra [Hash] optional params:
      #   - boroughCrossStreetTwo: The borough in which the cross_street_two is located if it differs from the borough parameter
      #   - compassDirection: Used when requesting information about only one side of the street (north, south, west, east, n, s, w, e)
      # @return [Hashie::Mash]
      # @example information about a segment defined by an on street between two cross-streets
      #   NYCGeoClient.blockface('34 st', 'fifht ave', 'manhattan')
      # @format :json, :xml
      def intersection(cross_street_one:, cross_street_two:, borough:, borough_cross_street_two: nil, compass_direction: nil)
        options = {
          crossStreetOne: cross_street_one,
          crossStreetTwo: cross_street_two,
          borough: borough,
          boroughCrossStreetTwo: borough_cross_street_two,
          compassDirection: compass_direction
        }.reject { |k, v| v.nil? }
        get(intersection_path, options)
      end

      protected

      def intersection_path
        "intersection"
      end
    end
  end
end