#!/usr/bin/ruby

#INDIVIDUAL PAGE FOR EVERY RECORD

#require the necessary libraries
require 'cgi'
require 'uri'
require 'cgi'
require 'cgi/session'
require 'rexml/document'
include REXML

cgi = CGI.new
cgi.params

#access the cgi session created in login.cgi
sess = CGI::Session.new(cgi, 
					"session_key" => "SESSIONID",
                        "prefix" => "web-session.")

par = CGI.parse(URI.parse(ENV["REQUEST_URI"]).query) #{"record_id"=>["2"]}
recordId = par['record_id'].first 				   #2

#get the xml file containing the records
xmlfile = File.new("database/records.xml")

#make it an xml document
xmldoc = Document.new(xmlfile)

#get the root element
root = xmldoc.root

#PREVENTS DEEP LINKING
if sess['loggedin'] != "TRUE"
	puts cgi.header({"Content-Type" => "text/html", "Location" => "login.cgi"})
else
	puts cgi.header("Content-Type: text/html")
end

#puts cgi.header("Content-Type: text/html")


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


						<h1>Record #{recordId}</h1>

					</div>
				</div>
			</div>
		</div>
		
		<div class="main-content">
			<div class="container">
				<div class="row" style="padding:25px; background-color:#{root.elements["//record[id=#{recordId}]/image"].attributes['background']};">
HEAD

#part of the html document
puts <<SINGLE_RECORD
<div class="col-md-6 col-sm-12">
	<div class="record-img">
		<!-- 
				Records pictures downloaded from
				http://bavotasan.com/2008/6-free-vinyl-record-vectors/ 
				Made by: by c.bavota 
			-->
		<img src="#{root.elements["//record[id=#{recordId}]/image"].text}" alt="#{root.elements["//record[id=#{recordId}]/rtitle"].text}">
	</div>
</div>
<div class="col-md-6 col-sm-12">
	<div class="record-description">
		<p style="color:#{root.elements["//record[id=#{recordId}]/description"].attributes['color']};">#{root.elements["//record[id=#{recordId}]/description"].text}</p>
	</div>
	<a 	onMouseOver="this.style.backgroundColor = '#{root.elements["//record[id=#{recordId}]/description"].attributes['color']}'; 
			  	   this.style.border = '2px solid #{root.elements["//record[id=#{recordId}]/interest"].attributes['background']}'; 
			        this.style.color = '#{root.elements["//record[id=#{recordId}]/interest"].attributes['background']}';" 
		
		onMouseOut="this.style.backgroundColor = '#{root.elements["//record[id=#{recordId}]/interest"].attributes['background']}'; 
			  this.style.color = '#{root.elements["//record[id=#{recordId}]/description"].attributes['color']}'; 
	  		  this.style.border = '2px solid #{root.elements["//record[id=#{recordId}]/description"].attributes['color']}';"
	
		style="color:#{root.elements["//record[id=#{recordId}]/description"].attributes['color']};
			  border: 2px solid #{root.elements["//record[id=#{recordId}]/description"].attributes['color']};
			  background-color: #{root.elements["//record[id=#{recordId}]/interest"].attributes['background']};"

		class="interest-btn"
		href="interest.cgi?record_id=#{recordId}&interest=true">

		<i class="fa fa-star fa-lg"></i>
		Express Interest
		</a>
</div>
SINGLE_RECORD
	
#part of the html document
puts <<FOOT
	
					</div>
				</div>
			</div>
		</div><!-- /.main-content -->
		
		
		<footer>
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<a class="bktohp-btn"href="index.cgi">Back to Home page</a>
					</div>
				</div>
			</div>	
		</footer>
		
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
		<script type="text/javascript" src="..//bootstrap.js"></script>
	</body>

</html>
FOOT
