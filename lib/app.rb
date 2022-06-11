class App
    def initialize(router, controller, session_manager)
        @router = router
        @controller = controller
        @session_manager = session_manager
    end

	def handle(request)
        route = @router.route(request)

        if route.nil? || !@controller.respond_to?(route.controller_method)
            return @controller.not_found(request)
        end

        session = @session_manager.get

        if route.parameters['middleware'] === 'auth' && !session['username']
            return Response.new('', 302, {'location' => '/login'})
        end

        if route.parameters['middleware'] === 'guest' && session['username']
            return Response.new('', 302, {'location' => '/'})
        end

        if route.name === 'logout'
            @session_manager.delete
        end

        @controller.send(route.controller_method, request)
	end
end
