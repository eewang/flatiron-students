require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'pry'
require_relative 'models/model.rb'

get '/'
  "Hello World!"
end
