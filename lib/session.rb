class SessionManager
    def initialize(session)
        @session = session
    end

    def get()
        @session
    end

    def delete()
        @session.delete   
    end
end
