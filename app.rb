require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'pry'
require_relative 'models/model.rb'

# Load Ruby script that scrapes all data from the Flatiron students website
# Add functionality to enable a user to input students via the browser

get '/' do
  erb :index
end

post '/' do
  input = request.POST 

  @student_row = Student.new( :name => input["name"],
                              :tagline => input["tagline"])
  @student_row.save

  "success"
end

get '/students/:student_name' do
  @student = params[:student_name].split
  erb :students
end

DataMapper.finalize
DataMapper.auto_upgrade!

get '/input' do
  # Form for browser input
  erb :input
end

get '/find/by-name/:student' do
  # get student data
  name = params[:student]
  @student = Student.all(:name => name)
  if @student.empty?
    "Sorry, there are no students with the name '#{name}'. Please try again."
  else
    erb :search_result
  end
end

get '/find/by-name' do
  erb :search_by_name
end

post '/find/by-name' do
  search_term = params['search_by_name']
  redirect "/find/by-name/#{search_term}"
end

post '/scrape' do
  record = request.POST

  @student_row = Student.new(
    :name => record['name'],
    :tagline => record['tagline'],
    :bio => record['bio'],
    :aspirations => record['aspirations'],
    :interests => record['interests'],
    :social_links => record['social_links'],
    :prevwork => record['prevwork'],
    :education => record['education'],
    :codercred => record['codercred'],
    :fave_apps => record['fave_apps'],
    :companies => record['companies'],
    :quotes => record['quotes']
    )
  @student_row.save
end

post '/input' do
  @student_row = Student.new(
    :name => params['name'],
    :tagline => params['tagline'],
    :bio => params['bio'],
    :aspirations => params['aspirations'],
    :interests => params['interests'],
    :social_links => params['social_links'],
    :prevwork => params['prevwork'],
    :education => params['education'],
    :codercred => params['codercred'],
    :fave_apps => params['fave_apps'],
    :companies => params['companies'],
    :quotes => params['quotes']
    )
  @student_row.save
  redirect "/input/success"
end

get '/input/success' do
  "SUCCESS!!! You are awomsome!"
end
