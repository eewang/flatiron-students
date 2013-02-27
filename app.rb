require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'pry'
require 'net/http'
require 'open-uri'
require 'nokogiri'
require_relative 'models/model.rb'

# Load Ruby script that scrapes all data from the Flatiron students website
# Add functionality to enable a user to input students via the browser

def get_images
  @images = []
  url = "http://students.flatironschool.com"
  @doc = Nokogiri::HTML(open(url))
  image_links = @doc.css("img").each do |image|
    @images << image.attr("src")
  end
end

get '/' do
  @images = get_images
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

get '/edit' do
  # Form for browser input
  erb :edit
end

get '/:student' do
  student_query = params[:student].gsub(" ", "-").downcase
  record = Student.all(:slug => student_query)
  @student = record[0]
  if record.size == 0
    "Sorry, that student does not exist"
  else
    erb :profile_html
  end

end

post '/scrape' do
  record = request.POST

  @student_row = Student.new(
    :name => record['name'],
    :profile_image => record['profile_image'],
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
    :quotes => record['quotes'],
    :slug => record['slug']
    )
  @student_row.save
end

post '/input' do
  @student_row = Student.new(
    :name => params['name'],
    :profile_image => record['profile_image'],
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
    :quotes => params['quotes'],
    )
  @student_row.save
  redirect "/input/success"
end

get '/input/success' do
  "SUCCESS!!! You are awomsome!"
end
