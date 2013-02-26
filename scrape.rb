require 'pry'
require 'net/http'
require 'open-uri'
require 'nokogiri'
require 'sqlite3'
require_relative 'models/model'

url = "http://students.flatironschool.com"   #Insert URL in quotes 

class Student
  attr_accessor :id, :doc, :name, :tagline, :bio, :aspirations, :interests, :social_links, :prevwork, :education, :codercred, :fave_apps, :companies, :quotes

  # @@db = SQLite3::Database.new("students.db")

  def initialize( name = "")
    # @id = Student.count_records
    @name = name
    @tagline = tagline
  end

  def scrape_name
    self.name = doc.css("h1").text
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
    self.social_links = (doc.css("div.social_icons a")).collect {|social_link| social_link.attr("href")}.join(", ")
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
    self.education = doc.css(".one_half:nth-child(2) li:first").text
  end

  def scrape_codercred
    # self.social_links = (doc.css("div.social_icons a")).collect {|social_link| social_link.attr("href")}
    self.codercred = (doc.css("#coder-cred td a")).collect { |codercred| codercred.attr("href")}.join(", ")
  end

  def scrape_fave_apps
    self.fave_apps = doc.css(".center:nth-child(3) .one-third + figcaption").text
  end

  def scrape_companies
    self.companies = doc.css("#favorites .columns:last .one_third figcaption").text
  end

  def scrape_quotes
    self.quotes = doc.css(".center:last").text
  end

  def scrape_all
    scrape_name
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

  # def self.find(id)
  #   record = @@db.execute("SELECT * FROM students WHERE id = (?) Limit 1", [id]).flatten
  #     student = Student.new
  #     student.name = record[1]
  #     student.tagline = record[2]
  #     student.bio = record[3]
  #     student.aspirations = record[4]
  #     student.interests = record[5]
  #     student.social_links = record[6]
  #     student.prevwork = record[7]
  #     student.education = record[8]
  #     student.codercred = record[9]
  #     student.fave_apps = record[10]
  #     student.companies = record[11]
  #     student.quotes = record[12]
  #   student
  # end

  # def save
  #   if self.class.find_by_name(@name)
  #   # @@db.execute(
  #       # "INSERT INTO students (name, tagline, bio, aspirations, interests, social_links, prevwork, education, codercred, fave_apps, companies, quotes)
  #       # VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
  #       # [name, tagline, bio, aspirations, interests, social_links, prevwork, education, codercred, fave_apps, companies, quotes]);
  #       if self.class.find_by_name(@name)
  #           @@db.execute("INSERT INTO students (name, tagline, bio, aspirations, interests, social_links, prevwork, education, codercred, fave_apps, companies, quotes) 
  #               VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", [name, tagline, bio, aspirations, interests, social_links, prevwork, education, codercred, fave_apps, companies, quotes]);
  #       else
  #           @@db.execute("UPDATE students SET (name, tagline, bio, aspirations, interests, social_links, prevwork, education, codercred, fave_apps, companies, quotes) 
  #             VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", [name, tagline, bio, aspirations, interests, social_links, prevwork, education, codercred, fave_apps, companies, quotes]);
  #       end
  #    end
  # end

  # def self.all
  #   all_students = []
  #   # Student.all #=> should return all student instances and create objects
  #   records = @@db.execute( "SELECT * FROM students" )
  #   all_students = records.collect do |person|
  #     student = Student.new.tap do |s|
  #       s.name = person[1]
  #       s.tagline = person[2]
  #       s.bio = person[3]
  #       s.aspirations = person[4]
  #       s.interests = person[5]
  #       s.social_links = person[6]
  #       s.prevwork = person[7]
  #       s.education = person[8]
  #       s.codercred = person[9]
  #       s.fave_apps = person[10]
  #       s.companies = person[11]
  #       s.quotes = person[12]
  #     end
  #   end


    # genre = Genre.new.tap{|g| g.name = 'rap'}
   #  all_the_students = []

   #  i = 0
   #  rows.flatten.each do |student|
   #    student = Student.new(rows[i][0], rows[i][1])
   #    all_the_students << student
   #    i += 1
   #    # i = all_the_students.length
   #  end
   # all_the_students
  # end

  # def self.size
  #   all.size
  # end

  # def save
  #   search_name = @@db.execute("SELECT name FROM students WHERE id = (?)", [id]).flatten;
  #   binding.pry
  #   if search_name = self.name
  #     @@db.execute("
  #       UPDATE ")
  #   else
  #     @@db.execute(
  #       "INSERT INTO students (name, tagline, bio, aspirations, interests, social_links, prevwork, education, codercred, fave_apps, companies, quotes)
  #       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
  #       [name, tagline, bio, aspirations, interests, social_links, prevwork, education, codercred, fave_apps, companies, quotes]);
  #   end
  # end

  # def self.count_records
  #   count = @@db.execute(
  #     "SELECT COUNT(name) FROM students"
  #     ).flatten
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
  student = Student.new
  student.doc = document
  student_name = student.scrape_name
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

  response = Net::HTTP.post_form(uri, 
    "name" => student_name, 
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
