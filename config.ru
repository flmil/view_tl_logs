require 'bundler'
Bundler.require

#require './slack_situation'
require './app'
run Sinatra::Application
