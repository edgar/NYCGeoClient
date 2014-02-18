module NYCGeoClient
  class Client
    # Defines methods related to branches
    module BBL

      # Returns property level information about a tax lot.
      #
      # @param borough [String] The borough in which the address is located
      # @param block [String] Tax block number
      # @param lot [String] Tax lot number
      # @return [Hashie::Mash]
      # @example property level information about a tax lot
      #   NYCGeoClient.bbl('manhattan','00233', '0004')
      # @format :json, :xml
      def bbl(borough, block, lot)
        options = {
          block:   block,
          lot:     lot,
          borough: borough
        }
        get(bbl_path, options)
      end

      protected

      def bbl_path
        "bbl"
      end
    end
  end
end