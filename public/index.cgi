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

cgi = CGI.new

app = App.new(
    Router.new(
        ENV["REQUEST_URI"],
        cgi,
        Controller.new(
            Renderer.new
        ),
        SessionManager.new(
            CGI::Session.new(cgi)
        )
    )
)

app.run
