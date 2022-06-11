class Router
    def initialize(controller, session_manager)
        @controller = controller
        @session_manager = session_manager
    end

    def route(request)
        case
        # /
        when /^\/$/.match(request.uri)
            session = @session_manager.get
            if session['username'].nil?
                return Response.new('', 302, {'location' => '/login'})
            end

            @controller.home(session)
        # /records/{id}
        when /^\/records\/([0-9]+)$/.match(request.uri)
            session = @session_manager.get
            if session['username'].nil?
                return Response.new('', 302, {'location' => '/login'})
            end

            @controller.record($1, session)
        # /records/{id}/interest
        when /^\/records\/([0-9]+)\/interest$/.match(request.uri)
            session = @session_manager.get
            if session['username'].nil?
                return Response.new('', 302, {'location' => '/login'})
            end

            @controller.interest($1, session)
        # /login
        when /^\/login$/.match(request.uri)
            session = @session_manager.get
            if !session['username'].nil?
                return Response.new('', 302, {'location' => '/'})
            end

            @controller.login(request, session)
        # /logout
        when /^\/logout$/.match(request.uri)
            session = @session_manager.get
            if session['username'].nil?
                return Response.new('', 302, {'location' => '/login'})
            end

            @session_manager.delete

            @controller.logout(request)
        else
            @controller.not_found(request)
        end
    end
end
