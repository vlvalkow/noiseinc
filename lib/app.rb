class App
    def initialize(cgi, router)
        @cgi = cgi
        @router = router
    end

	def run()
        puts @cgi.header
        puts @router.route(@cgi)
	end
end
