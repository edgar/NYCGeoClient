module NYCGeoClient
  class Client
    # Defines methods related to branches
    module Place

      # Returns address information using a well-known place name as input.
      #
      # @param name [String] A well-known New York City place name
      # @param borough [String] The borough in which the place is located
      # @return [Hashie::Mash]
      # @example address information using a well-known place name
      #   NYCGeoClient.place('empire state building')
      # @format :json, :xml
      def place(name:, borough: nil, zip: nil)
        options = {
          name:    name,
          borough: borough,
          zip: zip
        }.reject { |k, v| v.nil? }
        get(place_path, options)
      end

      protected

      def place_path
        "place"
      end
    end
  end
end