class App
    def initialize(router)
        @router = router
    end

	def run()
        @router.route()
	end
end
