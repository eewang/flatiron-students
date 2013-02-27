require 'pry'
require 'net/http'
require 'open-uri'
require 'nokogiri'
require 'sqlite3'
require_relative 'models/model'

url = "http://students.flatironschool.com"   #Insert URL in quotes 

class Student
  attr_accessor :id, :doc, :name, :profile_image, :tagline, :bio, :aspirations, :interests, :social_links, :prevwork, :education, :codercred, :fave_apps, :companies, :quotes

   @@db = SQLite3::Database.new("students.db")

  def initialize( name = "")
    # @id = Student.count_records
    @name = name
    @tagline = tagline
  end

  def scrape_name
    self.name = doc.css("h1").text
  end

  def scrape_profile_image
    self.profile_image = (doc.css("div.one_third img")).attr("src").value
  end

  def scrape_tagline
    self.tagline = doc.css(".two_third h2").text
  end
  def scrape_bio
    self.bio = doc.css(".two_third p:first").text
  end
  def scrape_aspirations
    self.aspirations = doc.css(".two_third p:nth-of-type(2)").text
  end
  
  def scrape_interests

     self.interests = doc.css(".two_third p:nth-of-type(3)").text
     self.interests = doc.css(".two_third p:not(:first)").text

  end

  def scrape_social_links
    self.social_links = (doc.css("div.social_icons a")).collect {|social_link| social_link.attr("href")}.join("~")
    # social_links = []
    # self.social_links = []
    # # for every i in social links
    # social_link_elements.each do |i_element|
    #   # # get the class of the i and strip off the icon-
    #   # link_type = i_element['class'].gsub("icon-", "")
    #   # then go up to the parent a and get the href
    #   link_href = i_element.parent['href']
    #   puts link_href
    #   # group those together as a key value pair
    # #   social_links << {link_type.to_sym => link_href}
    # # print social_links
    #   self.social_links << link_href
    #puts self.social_links
    # end
  end

  def scrape_prevwork
    self.prevwork = doc.css(".one_half:first li").text
  end

  def scrape_education
    self.education = (doc.css(".one_half:nth-child(2) li")).collect {|ed| ed.text}.join("~")
  end

  def scrape_codercred
    # self.social_links = (doc.css("div.social_icons a")).collect {|social_link| social_link.attr("href")}
    self.codercred = (doc.css("#coder-cred td a")).collect { |codercred| codercred.attr("href")}.join("~")
  end

  def scrape_fave_apps
    self.fave_apps = (doc.css(".one_third p")).collect {|apps| apps.text}.join("~")
  end

  def scrape_companies
    self.companies = (doc.css("#favorites .columns:last .one_third")).collect {|inc| inc.text}.join("~")
  end

  def scrape_quotes
    self.quotes = (doc.css(".one_fourth")).collect {|q| q.text}.join("~")
  end

  def scrape_all
    scrape_name
    scrape_profile_image
    scrape_tagline
    scrape_bio
    scrape_aspirations
    scrape_interests
    scrape_social_links
    scrape_prevwork
    scrape_education
    scrape_codercred
    scrape_fave_apps
    scrape_companies
    scrape_quotes
  end

  # def self.find_by_name(name)
  #      rows = @@db.execute("SELECT * FROM students WHERE name = ? Limit 1", name)
  #      student = Student.new
  #      student.name = rows.flatten[1]
  #      student.id = rows.flatten[0]
  #      student

  #      # if the name is empty, return false
  #     #  if rows == []
  #     #     false
  #     #  # if the name exists, return result
  #     # else   
  #      # result = rows.flatten[1]
  #      # result.bio = rows.flatten[2]
  #  # end
  # end

  # def self.size
  #   all.size
  # end

end

@@document = Nokogiri::HTML(open("#{url}"))

target = '.one_third a:first'

student_links = Array.new
page_targets_hash = Hash.new

@@document.css("#{target}").each do |item|
  profile_link = ""
  if item.attributes["href"].to_s.start_with?("./") || (item.attributes["href"].to_s.end_with?("html") || item.attributes["href"].to_s.end_with?("htm")) == false
    profile_link = ""
  else
    profile_link = item.attributes["href"]
    student_links << "http://students.flatironschool.com/" + profile_link.to_s.chomp
  end
end

uri = URI("http://0.0.0.0:9292/scrape")

student_links.each do |link|
  begin 
    document = Nokogiri::HTML(open(link))
  rescue
    next
  end
  begin
    student = Student.new
    student.doc = document
    student_name = student.scrape_name
    student_profile_image = url + "/" + student.scrape_profile_image
    student_tagline = student.scrape_tagline
    student_bio = student.scrape_bio
    student_aspirations = student.scrape_aspirations
    student_interests = student.scrape_interests
    student_social_links = student.scrape_social_links
    student_prevwork = student.scrape_prevwork
    student_education = student.scrape_education
    student_codercred = student.scrape_codercred
    student_fave_apps = student.scrape_fave_apps
    student_companies = student.scrape_companies
    student_quotes = student.scrape_quotes
    binding.pry

    response = Net::HTTP.post_form(uri, 
      "name" => student_name, 
      "profile_image" => student_profile_image,
      "tagline" => student_tagline,
      "bio" => student_bio,
      "aspirations" => student_aspirations,
      "interests" => student_interests,
      "social_links" => student_social_links,
      "prevwork" => student_prevwork,
      "education" => student_education,
      "codercred" => student_codercred,
      "fave_apps" => student_fave_apps,
      "companies" => student_companies,
      "quotes" => student_quotes
    )

  rescue
    next
  end
  
end



#---------------Student Class----------#

# db = SQLite3::Database.new("students.db")
# rows = db.execute <<-SQL
#   CREATE TABLE IF NOT EXISTS students (
#     id INTEGER PRIMARY KEY,
#     name text,
#     tagline text,
#     bio text,
#     aspirations text,
#     interests text,
#     social_links text,
#     prevwork text,
#     education text,
#     codercred text,
#     fave_apps text,
#     companies text,
#     quotes text
#   );
# SQL

all_students = []

# Student.count_records
