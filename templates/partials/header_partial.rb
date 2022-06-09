class HeaderPartial
	def render(data = {})
		<<-PARTIAL
        <header>
            <nav class="navbar navbar-default">
                <div class="container">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="/">Noise Inc</a>
                    </div>
                    <ul class="nav navbar-nav navbar-right">
                        #{if !data['username'].nil?
                            <<-LOGGED_IN_USER_ACTIONS
                            <li style="color:#e7e7e7; font-size:14px; margin: 13px 0px;">
                                Hello, #{data['username']}! 
                                <a class="logout-btn" style="display:inline;" href="/logout">Log out</a>
                            </li>
                            LOGGED_IN_USER_ACTIONS
                        else
                            <<-GUEST_USER_ACTIONS
                            <li><a href="/">Log in / Register</a></li>
                            GUEST_USER_ACTIONS
                        end}
                    </ul>
                </div>
            </nav>
        </header>
		PARTIAL
	end
end
