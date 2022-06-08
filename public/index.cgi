#!/usr/bin/ruby
 
require 'cgi'
require 'uri'
require 'rexml/document'

require '../lib/app'
require '../lib/router'
require '../lib/renderer'
require '../lib/controller'

app = App.new(
    CGI.new, 
    Router.new(
        ENV["REQUEST_URI"],
        Controller.new(
            Renderer.new
        )
    )
)

app.run
