class App
    def initialize(router)
        @router = router
    end

	def handle(request)
        @router.route(request)
	end
end
