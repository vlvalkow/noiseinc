class Route
    def initialize(name, url_pattern, parameters = {})
        @name = name
        @url_pattern = url_pattern
        @parameters = parameters
    end

    def match(url)
        match_data = url.match(@url_pattern)

        if match_data.nil?
            return false
        end

        if match_data.instance_of? MatchData
            @parameters = @parameters.merge(match_data.named_captures)
        end

        true
    end

    def name()
        @name
    end

    def controller_method()
        @name
    end
    
    def parameters()
        @parameters
    end
end
