#!/usr/bin/ruby

#EXPRESS INTEREST PAGE

#include the necessary libraries
require 'cgi'
require 'uri'
require 'cgi'
require 'cgi/session'
require 'rexml/document'

cgi = CGI.new
cgi.params

#access the cgi session created in login.cgi
sess = CGI::Session.new(cgi, 
					"session_key" => "SESSIONID",
                    	"prefix" => "web-session.")

#get the url of the page using the uri library and the environment variable ENV["REQUEST_URI"]
par = CGI.parse(URI.parse(ENV["REQUEST_URI"]).query) #{"record_id"=>["2"]}
recordId = par['record_id'].first 				   #2

#include REXML so that we don't have to write REXML::
#File instead of REXML::File
include REXML

#get the file
xmlfile = File.new("database/records.xml")

#make it a xml document
xmldoc = Document.new(xmlfile)

#get the root element - <catalogue/>
root = xmldoc.root

#if the session variable loggedin (with default value = false) is not true - redirect to login page
#PREVENTS DEEP LINKING
if sess['loggedin'] != "TRUE"
	puts cgi.header({"Content-Type" => "text/html", "Location" => "login.cgi"})
else
	puts cgi.header("Content-Type: text/html")
end


#part of the html document

puts "<html lang=\"en\">"
	puts "<head>"

	require "./requires/head.rb"

puts "</head>"
puts <<HEAD
	<body>
		<header>
			<nav class="navbar navbar-default">
				<div class="container">
				<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="index.cgi">Noice Inc</a>
					</div>

					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

						<ul class="nav navbar-nav navbar-right">

							<li style="color:#e7e7e7; font-size:16px; margin: 13px 0px;">Hello, #{sess['user']}!<a class="logout-btn" style="display:inline;" href="logout.cgi">Log out</a></li>"
						</ul>
					</div><!-- /.navbar-collapse -->
					
				</div><!-- /.container-fluid -->
			</nav>
		</header>
		
		
		
			<div class="page-title">
				<div class="container">
					<div class="row">
						<div class="col-md-12">

	
							<h1>Interest expressed successfully!</h1>

						</div>
					</div>
				</div>
			</div>
		<div class="main-content">		
			<div class="container">
				<div class="row">
					<div class="record-list">
HEAD

#parse the interest parameter from the url
interest = par['interest'].first

#if true
if interest == "true"

#display a message to the user
	puts "					<div class=\"success_message\">
								<p>Thank you #{sess['user']}, for expressing interest in Record #{recordId}</p>
							</div>"
	puts "					<a style=\"padding:15px 30px;\" class=\"login-btn\" href=\"index.cgi\">Back to catalogue</a>"

#append the action to interest.log	
	interestLog = File.new("log/interest.log", "a+")
	interestLog.puts "User #{sess['user']} expresed interest in Record #{recordId}."
	interestLog.close
end

	
#part of the html document
puts <<FOOT
						</div>
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
