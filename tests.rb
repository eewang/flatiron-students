require 'pry'
require 'net/http'
require_relative 'models/model'

puts "What is the student's name?"
student_name = gets.chomp

puts "What is the student's tagline?"
student_tagline = gets.chomp

uri = URI("http://0.0.0.0:9292/")

response = Net::HTTP.post_form(uri, "name" => student_name, "tagline" => student_tagline)