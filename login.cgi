#!/usr/bin/ruby

#LOGIN PAGE

#require the necessary libraries
require "rexml/document"								
require 'cgi'
require 'cgi/session'
require 'digest/md5'

#include the REXML Class so that REXML::Document becomes Document
include REXML

cgi = CGI.new
cgi.params										

#variable that will store the session
sess = ""


#form submission is false by default
form_set = FALSE

#message variables
error_username = ""
error_password = ""
login_success = ""
login_error = ""

#check if form is submitted
if ENV['REQUEST_METHOD'] == "POST"
	form_set = TRUE
end

#login form validation
if cgi['username'] == ""
	error_username = "Please enter a username."
end
if cgi['password'] == ""
	error_password = "Please enter a password."
end

#read the xml file containing the users (users.xml)
xmlFile = File.open("database/users.xml", "r")

#create a document from the file
xmlDocument = Document.new xmlFile

#if the form is submitted
if ENV['REQUEST_METHOD'] == "POST"

#check each of the user elements
	XPath.each( xmlDocument, "//user") { |e|

#check username and password
	if e[2].text == cgi['username'] && e[3].text == Digest::MD5.hexdigest( cgi["password"] )

#create a session
		sess = CGI::Session.new( cgi, 
							"session_key" => "SESSIONID",
				               "session_id"  => "0000#{e[0].text}",
				               "new_session" => true,
				               "prefix"      => "web-session.")

		sess["loggedin"] = "TRUE"
		sess["user"] = cgi['username']

		login_error = ""
		login_success = "Login successful! Welcome " + sess["user"] + "!"
		break
	else 
	    login_error = "User/Password combination incorrect."
	end

	}

end

puts cgi.header("Content-Type: text/html")

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
HEAD
	if form_set && error_username == "" && error_password == "" && login_error == ""
		puts "<li style=\"color:#e7e7e7; font-size:16px; margin: 13px 0px;\">Hello, #{sess["user"]}<a class=\"logout-btn\" style=\"display:inline;\" href=\"logout.cgi\">Log out</a></li>"
	else
		puts "<li><a href=\"login.cgi\">Log in / Register</a></li>"
	end
puts <<PAGE_TITLE
							
						</ul>
					</div><!-- /.navbar-collapse -->
					
				</div><!-- /.container-fluid -->
			</nav>
		</header>
		
			<div class="page-title">
				<div class="container">
					<div class="row">
						<div class="col-md-12">

							
							<h1>Login</h1>

						</div>
					</div>
				</div>
			</div>
		<div class="main-content">
			<div class="container">
					<div class="row">
							<div class="col-md-12">
PAGE_TITLE

#display error messages
if form_set && (error_username != "" || error_password != "")
	puts 			"<div class=\"error-box\">
						<p style=\"color:#fff\">Errors: 	</p>
						<p style=\"color:#fff\">#{error_username}<br/>#{error_password}</p>
					</div>"


#part of the html document
puts <<LOGIN
			
							<div class="login">
								<form method="post">
									<label for="username">Username:</label>
									<p><input type="text" name="username" value=""></p>
									<label for="password">Password:</label>
									<p><input type="password" name="password" value=""></p>
									<p class="submit"><input class="login-btn" type="submit" name="commit" value="Login"></p>
									<a style="color:#e7e7e7;" href="registration.cgi">Don't have an account?</a>
								</form>
							</div>
LOGIN

else

#success message
if login_success != ""
	puts "					<div class=\"success_message\">
								<p>#{login_success}</p>
							</div>"
	puts "					<a style=\"padding:15px 30px;\" class=\"login-btn\" href=\"index.cgi\">See the catalogue</a>"
else

if form_set
#part of the html document
puts "
							<div class=\"error-box\">
								<p style=\"color:#fff\">Errors:</p>
								<p style=\"color:#fff;\">#{login_error}</p>
							</div>"
end

puts <<LOGIN
							<div class="login">
								<form method="post">
									<label for="username">Username:</label>
									<p><input type="text" name="username" value=""></p>
									<label for="password">Password:</label>
									<p><input type="password" name="password" value=""></p>
									<p class="submit"><input class="login-btn" type="submit" name="commit" value="Login"></p>
									<a href="registration.cgi">Don't have an account?</a>
								</form>
							</div>

LOGIN

end

end

#part of the html document
<<FOOT
					</div>
				</div>
			</div>
		</div><!-- /.main-content -->
		
		
		<footer>
		
		</footer>
		
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
		<script type="text/javascript" src="../js/bootstrap.js"></script>
	</body>

</html>
FOOT
