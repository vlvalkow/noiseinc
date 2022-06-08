class HeadPartial
	def render(data = {})
		<<-PARTIAL
		<!--
		* Project: Noice Inc
		* Created by: Vladimir Valkov
		* Module: 77203 Web Systems Management
		* University of Hull, Scarborough Campus
		* 2016
		*-->
		
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title>Noice Inc | Online Record Catalogue</title>
	
		<link rel="stylesheet" type="text/css" href="/assets/css/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="/assets/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="/assets/css/style.css">
		PARTIAL
	end
end
