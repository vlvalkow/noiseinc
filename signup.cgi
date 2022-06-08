#!/usr/bin/ruby

# encoding: UTF-8

#ADD USER TO XML FILE PAGE

if ENV['REQUEST_METHOD'] != "POST"
	puts "Location: registration.cgi"
end

#specifies the type of the document
puts "Content-Type: text/html\n\n"						

#require the necessary libraries
require "rexml/document"								
require 'cgi'
require 'digest'

#include the REXML Class so that REXML::Document becomes Document
include REXML

cgi = CGI.new
cgi.params

#message variables
error_message_un = ""
error_message_email = ""
error_username = ""
error_email = ""
error_password = ""

#REGISTRATION FORM VALIDATION
if cgi['username'] == ""
	error_username = "Please enter a username."
end
if cgi['email'] == ""
	error_email = "Please enter an email."
end
if cgi['password'] == ""
	error_password = "Please enter a password."
end

#open file users.xml
xmlFile = File.open("database/users.xml", "r")

#create a document from the file
xmlDocument = Document.new xmlFile

#checks if the username and email are available
XPath.each( xmlDocument, "//user/username/text()") { |e| 
	if e == cgi["username"]
		error_message_un = "This username is taken. Please choose another one."
	end
		if e == cgi["email"]
		error_message_email = "This email is taken. Please choose another one."
	end
}

#if there are no error messages register the user
if error_message_un == "" && error_message_email == "" && error_username == "" && error_email == "" && error_password == ""

userId = xmlDocument.root.elements.size + 1

newUser = Element.new("user")							#create new <user/> element
	addId = newUser.add_element "id"					#add child element <id/> to the <user/> element
	addId.add_text "#{userId}"						#add text to the <id/> element
	addType = newUser.add_element "type"				#create the elements: <type/>
	addType.add_text 'user'								
	addUsername = newUser.add_element "username"			#<username>
	addUsername.add_text cgi["username"]
	addPassword = newUser.add_element "password"			#<password/> 
	
	encr_pass = Digest::MD5.hexdigest( cgi["password"] )
	addPassword.add_text encr_pass
	addEmail = newUser.add_element "email"				#and <email/> in a similar way
	addEmail.add_text cgi["email"]
xmlDocument.root.insert_after("//user[last()]", newUser)	#then add the newly created <user/> element to the file

newXmlFile = File.open("database/users.xml", "w")					#write the new content to the physical file
newXmlFile.puts xmlDocument

xmlFile.close										#close the files
newXmlFile.close

end


#part of the html document
puts "<html lang=\"en\">"
	puts "<head>"

	require "./requires/head.rb"

puts "</head>"
<<HEAD

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

							<li><a href="login.cgi">Log in / Register</a></li>						
						</ul>
					</div><!-- /.navbar-collapse -->
					
				</div><!-- /.container-fluid -->
			</nav>
		</header>
		
		

			<div class="page-title">
				<div class="container">
					<div class="row">
						<div class="col-md-12">

							<h1>Registration</h1>

						</div>
					</div>
				</div>
			</div>
		<div class="main-content">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
HEAD


#display error messages
if error_message_un !="" || error_message_email !="" || error_username != "" || error_email != "" || error_password != ""
	puts 				"<div class=\"error-box\">
							<p style=\"color:#fff\">Errors:</p>
							<p style=\"color:#fff\">#{error_message_un}<br/>#{error_message_email}<br/>#{error_username}<br/>#{error_email}<br/>#{error_password}</p>
						</div>"
#part of the html document
puts <<FORM

							<form method="post" action="signup.cgi">
								<label for="username">Username:</label>
								<p><input type="text" name="username" value=""></p>
								<label for="email">Email:</label>
								<p><input type="text" name="email" value=""></p>
								<label for="password">Password:</label>
								<p><input type="password" name="password" value=""></p>
								<p class="submit"><input class="login-btn" type="submit" name="register" value="Register"></p>
							</form>
FORM

else

#register the user
			puts "<div class=\"success_message\">
					<p>Congratulations #{cgi["username"]}! You have successfully registered!</p>
				</div>"

	puts "					<a style=\"padding:15px 30px;\" class=\"login-btn\" href=\"login.cgi\">Click here to login</a>"

end
						puts "</div>"

#part of the html document
<<FOOT
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

