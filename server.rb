require 'sinatra'
require 'json'
require 'coffee-script'

class App < Sinatra::Base

  #Sass::Plugin.options[:template_location] = 'public/stylesheets'
  #use Sass::Plugin::Rack

  get '/' do
    File.read(File.join('public', 'index.html'))
  end


  get '/application.js' do
    coffee :application
  end

end
