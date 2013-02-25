require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'pry'
require_relative 'models/model.rb'

get '/' do
  erb :index
end

get '/students/:student_name' do
  @student = params[:student_name].split
  erb :students
end