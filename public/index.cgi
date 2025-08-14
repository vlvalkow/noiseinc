#!/usr/bin/ruby
 
require 'cgi'
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
require '../lib/route'

cgi = CGI.new

routes = [
    Route.new('home', /^\/$/, {'middleware' => 'auth'}),
    Route.new('record', /^\/records\/(?<record_id>[0-9]+)$/, {'middleware' => 'auth'}),
    Route.new('interest', /^\/records\/(?<record_id>[0-9]+)\/interest$/, {'middleware' => 'auth'}),
    Route.new('login', /^\/login$/, {'middleware' => 'guest'}),
    Route.new('register', /^\/register$/, {'middleware' => 'guest'}),
    Route.new('logout', /^\/logout$/, {'middleware' => 'auth'}),
]

request = Request.new(
    ENV['REQUEST_METHOD'], 
    ENV["REQUEST_URI"],
    cgi.params
)

session_manager = SessionManager.new(CGI::Session.new(cgi))

app = App.new(
    Router.new(routes),
    Controller.new(Renderer.new, session_manager.get),
    session_manager
)

response = app.handle(request)
response.send(cgi)
