#!/usr/bin/ruby

#LOGOUT PAGE

#include the necessary libraries
require 'cgi'
require 'cgi/session'
require 'uri'


cgi = CGI.new
cgi.params

#access the cgi session created in login.cgi
sess = CGI::Session.new(cgi, 
					"session_key" => "SESSIONID",
                        "prefix" => "web-session.")
#kill the session
sess.delete

#redirect to homepage
puts cgi.header({"Content-Type" => "text/html", "Location" => "index.cgi?logout=true"})
