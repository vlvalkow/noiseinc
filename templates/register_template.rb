require '../templates/partials/head_partial'

class Template
    def render(data)
        head_partial = HeadPartial.new
        errors_html = ''
        if data && data['errors'] && data['errors'].any?
            errors_html = '<div class="error_message" role="alert"><p>' + data['errors'].map { |e| "<div>#{e}</div>" }.join + '</p></div>'
        end
        <<-TEMPLATE
        <html lang="en">
            <head>
                <title>Noise Inc | Register</title>
                #{head_partial.render}
            </head>
            <body>
                <div class="page-title">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <h1>Register</h1>
                            </div>
                        </div>
                    </div>
                </div>
                <main class="main-content">
                    <div class="container" style="margin-top:30px;">
                        <div class="row">
                            <div class="login">
                                #{errors_html}
                                <form method="post">
                                    <div class="form-group">
                                        <label for="username">Username:</label>
                                        <p>
                                            <input type="text" name="username" id="username" value="#{data && data['username'] ? data['username'] : ''}">
                                        </p>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Email:</label>
                                        <p>
                                            <input type="email" name="email" id="email" value="#{data && data['email'] ? data['email'] : ''}">
                                        </p>
                                    </div>
                                    <div class="form-group">
                                        <label for="email_confirm">Confirm Email:</label>
                                        <p>
                                            <input type="email" name="email_confirm" id="email_confirm" value="#{data && data['email'] ? data['email'] : ''}">
                                        </p>
                                    </div>
                                    <div class="form-group">
                                        <label for="password">Password:</label>
                                        <p>
                                            <input type="password" name="password" id="password">
                                        </p>
                                    </div>
                                    <div class="form-group">
                                        <label for="password_confirm">Confirm Password:</label>
                                        <p>
                                            <input type="password" name="password_confirm" id="password_confirm">
                                        </p>
                                    </div>
                                    <p class="submit">
                                        <input class="login-btn" type="submit" name="commit" value="Register">
                                    </p>
                                    <a style="color:#e7e7e7;" href="/login">Already have an account?</a>
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
