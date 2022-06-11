class Response
    def initialize(content = '', status = 200, headers = {})
        @content = content
        @status = status
        @headers = headers
    end

    def send(cgi)
        headers = @headers.merge({'status' => @status})
        puts cgi.header(headers)
        puts @content
    end
end
