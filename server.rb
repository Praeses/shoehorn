require 'sinatra'
require 'sinatra/reloader'
require 'fileutils'
require 'json'
require 'coffee-script'
require './models/app'

class Server < Sinatra::Base

  #Sass::Plugin.options[:template_location] = 'public/stylesheets'
  #use Sass::Plugin::Rack

  configure :development do
    #Sinatra::Application.reset!
    #use Rack::Reloader
    register Sinatra::Reloader
  end

  get '/' do
    File.read(File.join('public', 'index.html'))
  end

  get '/apps' do
    App.all.map{|h| h.to_hash }.to_json
  end

  get '/application.js' do
    coffee :application
  end

end
