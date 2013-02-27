require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'pry'

ENV['DATABASE_URL'] ||= "sqlite://#{Dir.pwd}/flatiron_students.db"

DataMapper.setup(:default, ENV['DATABASE_URL'])

class Student
  include DataMapper::Resource

  property :id, Serial
  property :name, Text
  property :tagline, Text
  property :bio, Text
  property :aspirations, Text
  property :interests, Text
  property :social_links, Text
  property :prevwork, Text
  property :education, Text
  property :codercred, Text
  property :fave_apps, Text
  property :companies, Text
  property :quotes, Text

end