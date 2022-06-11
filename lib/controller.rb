class Controller
    def initialize(renderer, session)
        @renderer = renderer
        @session = session
    end

    def home(request)
        xmlfile = File.new("../database/records.xml")
        records_xml_document = REXML::Document.new xmlfile
        records = records_xml_document.get_elements("//record")
        
        Response.new(@renderer.render('home_template', {
            'records' => records,
            'username' => @session['username']
        }))
    end

    def record(request)
        xmlfile = File.new("../database/records.xml")
        records_xml_document = REXML::Document.new xmlfile
        record = records_xml_document.get_elements("//record[id=#{request.parameters['record_id']}]").first

        Response.new(@renderer.render('record_template', {
            'record' => record,
            'username' => @session['username']
        }))
    end

    def interest(request)
        interestLog = File.new("../var/log/interest.log", "a+")
        interestLog.puts "User #{@session['username']} expresed interest in Record #{request.parameters['record_id']}."
        interestLog.close

        Response.new(@renderer.render('interest_template', {
            'record_id' => request.parameters['record_id'],
            'username' => @session['username']
        }))
    end

    def login(request)
        if request.method === 'POST'
            xmlfile = File.new("../database/users.xml")
            users_xml_document = REXML::Document.new xmlfile
            user = users_xml_document.get_elements("//user[username='#{request.parameters['username']}']").first

            if user.nil?
                return Response.new('', 302, {'location' => '/login'})
            end

            if user[7].text != Digest::MD5.hexdigest(request.parameters['password'])
                return Response.new('', 302, {'location' => '/login'})
            end
    
            @session['username'] = request.parameters['username']
            
            return Response.new('', 302, {'location' => '/login'})
        end

        Response.new(@renderer.render('login_template'))        
    end

    def logout(request)
        Response.new('', 302, {'location' => '/login'})
    end

    def not_found(request)
        Response.new(@renderer.render('not_found_template', {
            'request_uri' => request.uri
        }))
    end
end
