require '../templates/partials/head_partial'
require '../templates/partials/header_partial'


class Template
    def render(data)
        head_partial = HeadPartial.new
        header_partial = HeaderPartial.new

        <<-TEMPLATE
        <html land="en">
            <head>
                <title>Noise Inc | Interest</title>
                #{head_partial.render}
            </head>
            <body>
                #{header_partial.render({'username' => data['username']})}
                <div class="page-title">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <h1>Your interest was recorded!</h1>
                            </div>
                        </div>
                    </div>
			    </div>
                <main class="main-content">	
                    <div class="container" style="margin-top:30px;">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="success_message">
                                    <p>Thank you for expressing interest in Record #{data['record_id']}</p>
                                </div>
                                <a style="padding:15px 30px;" class="login-btn" href="/">Back to catalogue</a>"
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
