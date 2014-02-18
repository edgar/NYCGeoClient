module NYCGeoClient
  # Custom error class for rescuing from all NYCGeoClient errors
  class Error < StandardError
    attr_reader :status

    def initialize(message, status=nil)
      super(message)
      @status = status
    end
  end

end