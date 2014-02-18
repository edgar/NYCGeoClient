module NYCGeoClient
  class Client
    # Defines methods related to branches
    module BIN

      # Returns property level information about a building.
      #
      # @param bin [String] The bin in which the address is located
      # @return [Hashie::Mash]
      # @example property level information about a building
      #   NYCGeoClient.bin('1003041')
      # @format :json, :xml
      def bin(bin)
        options = {
          bin: bin
        }
        get(bin_path, options)
      end

      protected

      def bin_path
        "bin"
      end
    end
  end
end