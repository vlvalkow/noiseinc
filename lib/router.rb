class Router
    def initialize(request_uri, cgi, controller, session_manager)
        @request_uri = request_uri
        @cgi = cgi
        @controller = controller
        @session_manager = session_manager
    end
    
    def route()
        case
        # /
        when /^\/$/.match(@request_uri)
            session = @session_manager.get
            if session['username'].nil?
                puts @cgi.header('status' => '302', 'location' => '/login')
                abort
            end

            @controller.home(@cgi, session)
        # /records/{id}
        when /^\/records\/([0-9]+)$/.match(@request_uri)
            session = @session_manager.get
            if session['username'].nil?
                puts @cgi.header('status' => '302', 'location' => '/login')
                abort
            end

            @controller.record($1, @cgi, session)
        # /records/{id}/interest
        when /^\/records\/([0-9]+)\/interest$/.match(@request_uri)
            session = @session_manager.get
            if session['username'].nil?
                puts @cgi.header('status' => '302', 'location' => '/login')
                abort
            end

            @controller.interest($1, @cgi, session)
        # /login
        when /^\/login$/.match(@request_uri)
            session = @session_manager.get
            if !session['username'].nil?
                puts @cgi.header('status' => '302', 'location' => '/')
                abort
            end

            @controller.login(@cgi, session)
        # /logout
        when /^\/logout$/.match(@request_uri)
            session = @session_manager.get
            if session['username'].nil?
                puts @cgi.header('status' => '302', 'location' => '/login')
                abort
            end

            @controller.logout(@cgi, @session_manager)
        else
            @controller.not_found(@request_uri, @cgi)
        end
    end
end
