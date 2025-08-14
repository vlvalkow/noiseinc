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
                @session['error'] = 'Invalid username or password.'
                return Response.new('', 302, {'location' => '/login'})
            end

            password_element = user.elements['password']
            if password_element.nil? || password_element.text != Digest::MD5.hexdigest(request.parameters['password'])
                return Response.new(@renderer.render('login_template', {
                    'success' => nil,
                    'error' => 'Invalid username or password.',
                    'username' => request.parameters['username']
                }))
            end
    
            @session['username'] = request.parameters['username']
            
            return Response.new('', 302, {'location' => '/login'})
        end

        success = nil
        if @session['success']
            success = @session['success']
            @session['success'] = nil
        end

        error = nil
        if @session['error']
            error = @session['error']
            @session['error'] = nil
        end
        Response.new(@renderer.render('login_template', {'success' => success, 'error' => error}))        
    end

    def register(request)
        if request.method == 'POST'
            username = request.parameters['username']&.strip
            email = request.parameters['email']&.strip
            email_confirm = request.parameters['email_confirm']&.strip
            password = request.parameters['password']
            password_confirm = request.parameters['password_confirm']
            errors = []

            if username.nil? || username.empty?
                errors << 'Username is required.'
            end
            if email.nil? || email.empty?
                errors << 'Email is required.'
            end
            if email != email_confirm
                errors << 'Emails do not match.'
            end
            if password.nil? || password.empty?
                errors << 'Password is required.'
            end
            if password != password_confirm
                errors << 'Passwords do not match.'
            end

            # Check if username or email already exists
            xmlfile = File.new("../database/users.xml")
            users_xml_document = REXML::Document.new xmlfile
            existing_user = users_xml_document.get_elements("//user[username='#{username}']").first
            existing_email = users_xml_document.get_elements("//user[email='#{email}']").first
            
            if existing_user
                errors << 'Username already exists.'
            end

            if existing_email
                errors << 'Email already exists.'
            end

            if errors.any?
                return Response.new(@renderer.render('register_template', {
                    'errors' => errors,
                    'username' => username,
                    'email' => email
                }))
            end

            # Add new user
            users_root = users_xml_document.root
            new_user = REXML::Element.new('user')
            new_user.add_element('id').text = (users_root.elements.size + 1).to_s
            new_user.add_element('type').text = 'user'
            new_user.add_element('username').text = username
            new_user.add_element('password').text = Digest::MD5.hexdigest(password)
            new_user.add_element('email').text = email
            users_root.add_element(new_user)

            # Save XML with pretty formatting (4 spaces)
            File.open("../database/users.xml", "w") do |f|
                formatter = REXML::Formatters::Pretty.new(4)
                formatter.compact = true
                formatter.write(users_xml_document, f)
            end

            @session['success'] = 'Your account has been created successfully. Please login below.'
            return Response.new('', 302, {'location' => '/login'})
        end
        Response.new(@renderer.render('register_template'))
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
