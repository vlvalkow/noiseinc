class Template
    def render(data)
        <<-TEMPLATE
        <html>
            <head>
                <title>Noise Inc | Not Found</title>
            </head>
            <body>
                <h1>Not found</h1>
                <p>No route found for URI #{data['request_uri']} was not found</p>
            </body>
        </html>
        TEMPLATE
    end
end
