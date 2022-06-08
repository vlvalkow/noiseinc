class Controller
    def initialize(renderer)
        @renderer = renderer
    end

    def home()
        xmlfile = File.new("../database/records.xml")
        records_xml_document = REXML::Document.new xmlfile

        @renderer.render('home_template', {
          'records' => records_xml_document.get_elements("//record")  
        })
    end

    def record(record_id)
        xmlfile = File.new("../database/records.xml")
        records_xml_document = REXML::Document.new xmlfile

        @renderer.render('record_template', {
          'record' => records_xml_document.get_elements("//record[id=#{record_id}]").first  
        })
    end

    def interest(record_id, cgi)
        interestLog = File.new("../var/log/interest.log", "a+")
        interestLog.puts "А user expresed interest in Record #{record_id}."
        interestLog.close

        @renderer.render('interest_template', {
          'record_id' => record_id
        })
    end

    def not_found(request_uri)
        @renderer.render('not_found_template', {
            'request_uri' => request_uri
        })        
    end
end
