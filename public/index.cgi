#!/usr/bin/ruby
 
require 'cgi'
require 'uri'
require 'cgi/session'
require 'rexml/document'
require 'digest/md5'

require '../lib/app'
require '../lib/router'
require '../lib/renderer'
require '../lib/controller'
require '../lib/session'
require '../lib/request'
require '../lib/response'

cgi = CGI.new

request = Request.new(
    ENV['REQUEST_METHOD'], 
    ENV["REQUEST_URI"],
    cgi.params
)

app = App.new(
    Router.new(
        Controller.new(Renderer.new),
        SessionManager.new(CGI::Session.new(cgi))
    )
)

response = app.handle(request)
response.send(cgi)
