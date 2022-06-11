class Request
    def initialize(method, uri, parameters)
        @method = method
        @uri = uri
        @parameters = parameters.map { |k,v| [k, v.first] }.to_h
    end

    def method()
        @method
    end

    def uri()
        @uri
    end

    def parameters()
        @parameters
    end
end
