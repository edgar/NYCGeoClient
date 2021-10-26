module NYCGeoClient
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options={}, raw=false)
      request(:get, path, options, raw)
    end

    # Perform an HTTP POST request
    def post(path, options={}, raw=false)
      request(:post, path, options, raw)
    end

    # Perform an HTTP PUT request
    def put(path, options={}, raw=false)
      request(:put, path, options, raw)
    end

    # Perform an HTTP DELETE request
    def delete(path, options={}, raw=false)
      request(:delete, path, options, raw)
    end

    private

    # Perform an HTTP request
    def request(method, path, options, raw=false)
      response = connection(raw).send(method) do |request|
        path = formatted_path(path)
        case method
        when :get, :delete
          request.url(path, options)
        when :post, :put
          request.path = path
          request.body = options unless options.empty?
        end
      end
      if raw
        response
      elsif format == :xml
        response.body.geosupportResponse # the xml response is wrapped in <geosupportResponse> tags
      else
        response.body
      end
    end

    def formatted_path(path)
      [path, format].compact.join('.')
    end
  end
end
