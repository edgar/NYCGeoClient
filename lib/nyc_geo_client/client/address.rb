module NYCGeoClient
  class Client
    # Defines methods related to branches
    module Address

      # Returns block and property level information about an address.
      #
      # Results will include X/Y coordinates, political, city service
      # and property information as well as normalized street names and codes.
      #
      # @param house_number [String] The house number portion of the address
      # @param street [String] The street portion of the address
      # @param borough [String] The borough in which the address is located
      # @return [Hashie::Mash]
      # @example block and property level information about an address
      #   NYCGeoClient.address('13', 'crosby', 'manhattan')
      # @format :json, :xml
      def address(house_number, street, borough)
        options = {
          houseNumber: house_number,
          street: street,
          borough: borough
        }
        get(address_path, options)
      end

      protected

      def address_path
        "address"
      end
    end
  end
end