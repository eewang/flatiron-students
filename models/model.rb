require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require 'dm-sqlite-adapter'
require 'pry'

ENV['DATABASE_URL'] ||= "sqlite://#{Dir.pwd}/students.db"

DataMapper.setup(:default, ENV['DATABASE_URL'])

class Student
  include DataMapper::Resource

  property :id, Serial
  property :name, Text,           :lazy => false
  property :profile_image, Text,  :lazy => false
  property :tagline, Text,        :lazy => false
  property :bio, Text,            :lazy => false
  property :aspirations, Text,    :lazy => false
  property :interests, Text,      :lazy => false
  property :social_links, Text,   :lazy => false
  property :prevwork, Text,       :lazy => false
  property :education, Text,      :lazy => false
  property :codercred, Text,      :lazy => false
  property :fave_apps, Text,      :lazy => false
  property :companies, Text,      :lazy => false
  property :quotes, Text,         :lazy => false

end