class Controller
    def initialize(renderer)
        @renderer = renderer
    end

    def home(cgi, session)
        xmlfile = File.new("../database/records.xml")
        records_xml_document = REXML::Document.new xmlfile

        puts cgi.header
        puts @renderer.render('home_template', {
          'records' => records_xml_document.get_elements("//record"),
          'username' => session['username']
        })
    end

    def record(record_id, cgi, session)
        xmlfile = File.new("../database/records.xml")
        records_xml_document = REXML::Document.new xmlfile

        puts cgi.header
        puts @renderer.render('record_template', {
          'record' => records_xml_document.get_elements("//record[id=#{record_id}]").first,
          'username' => session['username']
        })
    end

    def interest(record_id, cgi, session)
        interestLog = File.new("../var/log/interest.log", "a+")
        interestLog.puts "User #{session['username']} expresed interest in Record #{record_id}."
        interestLog.close

        puts cgi.header
        puts @renderer.render('interest_template', {
          'record_id' => record_id,
          'username' => session['username']
        })
    end

    def login(cgi, session)
        if ENV['REQUEST_METHOD'] === 'POST'
            xmlfile = File.new("../database/users.xml")
            users_xml_document = REXML::Document.new xmlfile
            user = users_xml_document.get_elements("//user[username='#{cgi['username']}']").first
        
            if user.nil?
                puts cgi.header("status" => "302", "location" => "/login")
                abort
            end

            if user[7].text != Digest::MD5.hexdigest(cgi["password"])
                puts cgi.header("status" => "302", "location" => "/login")
                abort
            end
    
            session["username"] = cgi['username']

            puts cgi.header("status" => "302", "location" => "/")
            abort
        end

        puts cgi.header
        puts @renderer.render('login_template')
    end

    def logout(cgi, session_manager)
        session_manager.delete

        puts cgi.header("status" => "302", "location" => "/login")
        abort
    end

    def not_found(request_uri, cgi)
        puts cgi.header
        puts @renderer.render('not_found_template', {
            'request_uri' => request_uri
        })        
    end
end
