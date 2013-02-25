require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'pry'

ENV['DATABASE_URL'] ||= 'postgres://erinlee:@localhost/flatiron_students'

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