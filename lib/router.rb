class Router
    def initialize(request_uri, controller)
        @request_uri = request_uri
        @controller = controller
    end
    
    def route(cgi)
        case
        # /
        when /^\/$/.match(@request_uri)
            @controller.home()
        # /records/{id}
        when /^\/records\/([0-9]+)$/.match(@request_uri)
            @controller.record($1)
        # /records/{id}/interest
        when /^\/records\/([0-9]+)\/interest$/.match(@request_uri)
            @controller.interest($1, cgi)
        else
            @controller.not_found(@request_uri)
        end
    end
end
