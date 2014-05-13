ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require 'mongo'
require 'json/ext'
require 'sinatra/advanced_routes'
require 'active_support/all'

require_relative 'helpers'
require_relative 'routes/secrets'
require_relative 'routes/sessions'
require_relative 'routes/routes'
require_relative 'routes/users'

class Sinatrapi < Sinatra::Base
  include Mongo

  set :root, File.dirname(__FILE__)

  configure do
    client = MongoClient.new
    set :mongo_client, client
    set :mongo_db, client.db('davinci')
  end

  enable :sessions
  enable :method_override

  puts settings.mongo_db.inspect

  helpers Sinatra::Sinatrapi::Helpers

  register Sinatra::AdvancedRoutes
  register Sinatra::Sinatrapi::Routing::Sessions
  register Sinatra::Sinatrapi::Routing::Secrets
  register Sinatra::Sinatrapi::Routing::Routes
  register Sinatra::Sinatrapi::Routing::Users
end
