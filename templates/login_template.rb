require '../templates/partials/head_partial'

class Template
    def render(data)
        head_partial = HeadPartial.new

        <<-TEMPLATE
        <html land="en">
            <head>
                <title>Noise Inc | Login</title>
                #{head_partial.render}
            </head>
            <body>
                <div class="page-title">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <h1>Login</h1>
                            </div>
                        </div>
                    </div>
			    </div>
                <main class="main-content">	
                    <div class="container" style="margin-top:30px;">
                        <div class="row">
                            <div class="login">
								<form method="post">
                                    <div class="form-group">
									    <label for="username">Username:</label>
									    <p>
                                            <input type="text" name="username" id="username">
                                        </p>
                                    </div>
									<label for="password">Password:</label>
                                    <p>
                                        <input type="password" name="password" id="password">
                                    </p>
                                    <p class="submit">
                                        <input class="login-btn" type="submit" name="commit" value="Login">
                                    </p>
                                    <a style="color:#e7e7e7;" href="/register">Don't have an account?</a>
								</form>
							</div>
                        </div>
                    </div>
                </main>
                <footer>
                
                </footer>
            </body>
        </html>
        TEMPLATE
    end
end
