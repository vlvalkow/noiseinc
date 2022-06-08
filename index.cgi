#!/usr/bin/ruby

#HOMEPAGE

#include the necessary libraries
require 'cgi'
require 'cgi/session'
require 'uri'
require 'rexml/document'

cgi = CGI.new
cgi.params

#access the cgi session created in login.cgi
sess = CGI::Session.new(cgi,
					"session_key" => "SESSIONID",
                        "prefix" => "web-session.")

#add the content-type header
puts cgi.header("Content-Type: text/html")

#part of the html document

puts "<html lang=\"en\">"
	puts "<head>"

	require "./requires/head.rb"

puts "</head>"

puts "<body>"

puts <<HEADER
		<header>
			<nav class="navbar navbar-default">
				<div class="container">
					<div class="navbar-header">
						<a class="navbar-brand" href="index.cgi">Noice Inc</a>
					</div>
					<ul class="nav navbar-nav navbar-right">
HEADER

					#if the session variable user is set and it is not empty:
					#Display message: Hello, #{sess['user']}! Log out
					if !sess['user'].nil? && sess['user'] != ""
						puts "<li style=\"color:#e7e7e7; font-size:14px; margin: 13px 0px;\">Hello, #{sess['user']}!<a class=\"logout-btn\" style=\"display:inline;\" href=\"logout.cgi\">Log out</a></li>"
					else
						puts "<li><a href=\"login.cgi\">Log in / Register</a></li>"
					end

puts				"</ul>
				</div>
			</nav>
		</header>"

#get the url of the page using the uri library and the environment variable ENV["REQUEST_URI"]
uri = URI(ENV["REQUEST_URI"])

#if logout=true is part of the url parse the url
if uri.query == "logout=true"
	par = CGI.parse(URI.parse(ENV["REQUEST_URI"]).query) #{"logout"=>["true"]}
	logout = par['logout'].first #true
	if logout == "true"		
puts <<MESSAGE
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class=\"success_message\">
					<p>Logout sucessful!</p>
				</div>
			</div>
		</div>
	</div>
MESSAGE
	end
end

#part of the html document
puts <<PAGE_TITLE	
			<div class="page-title">
				<div class="container">
					<div class="row">
						<div class="col-md-12">

							
							<h1>Catalogue</h1>

						</div>
					</div>
				</div>
			</div>
		
		<div class="main-content">	
			<div class="container" style="margin-top:30px;">
				<div class="row">
					<div class="record-list">
PAGE_TITLE


#include REXML so that we don't have to write REXML::
#File instead of REXML::File
include REXML

#get the file
xmlfile = File.new("database/records.xml")

#make it a xml document
xmldoc = Document.new(xmlfile)

#get the root element - <catalogue/>
root = xmldoc.root

#loop to get all the record elements
xmldoc.elements.each("catalogue/record") { |e|


#part of the html document
puts <<LIST_RECORD
<div class="col-md-3" style="padding-left:9px; padding-right:9px;">
	<div class="record record-list">
		<div class="record-img" style="background-color:#{e[3].attributes["background"]};">
			<!-- 
			Records pictures downloaded from
			http://bavotasan.com/2008/6-free-vinyl-record-vectors/ 
			Made by: by c.bavota 
			-->
			<!-- get the forth child node of the record element (represents the image of the record) -->
			<img src="#{e[3].text}" alt="record alt text">
		</div>
		<div class="record-title">
			<!-- get the sixth child node of the record element (represents the title of the record) -->
			<h2>#{e[5].text}</h2>
		</div>
		<!-- 
		<div class="record-description">
			get the eight child node of the record element (represents the description of the record) 
			<p>#{e[7].text}</p>
		</div>
		 -->
		<!-- get the second child node of the record element (represents the id of the record) -->
		<a class="view-record-btn" href="record.cgi?record_id=#{e[1].text}">View record</a>
	</div>
</div>
LIST_RECORD
}

#part of the html document
puts <<FOOT
					</div>	
				</div>
			</div>
		</div><!-- /.main-content -->
		
		
		<footer>
		
		</footer>
		
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.js"></script>
	</body>

</html>
FOOT
