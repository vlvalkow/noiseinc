class Router
    def initialize(routes = [])
        @routes = routes
    end

    def route(request)
        @routes.find do |route|
            if !route.match(request.uri)
                next
            end
            
            request.parameters = request.parameters.merge(route.parameters)

            true
        end
    end
end
