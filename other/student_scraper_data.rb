require 'sqlite3'

db = SQLite3::Database.new("students.db")
rows = db.execute <<-SQL
  CREATE TABLE students (
    id INTEGER PRIMARY KEY autoincrement,
    name text,
    tagline text
  );
SQL

class Student
  attr_accessor :name, :tagline

  # @@db = SQLite3::Database.new "students.db"
  @@student_list = []

  def initialize(doc = "", name = "name", tagline = "tagline", bio, aspirations, interests, social_links, prevwork, education, fave_apps, companies, quotes)
    @name = name
    @tagline = tagline
    @@student_list << name
  end

  def self.student_size
    @@student_list.size
  end

  def save
    # @@db.execute(
    #     "INSERT INTO students (id, name, tagline)
    #     VALUES (?, ?, ?)", 
    #     [self.class.student_size, name, tagline]);
        if self.class.find_by_name(@name)
            @@db.execute("INSERT INTO students (name, tagline, bio) 
                VALUES(?, ?, ?)", [@name, @tagline, @bio]);
        else
              @@db.execute("UPDATE students SET bio=(?), tagline=(?) WHERE name=(?)", [@bio, @tagline, @name])
        end
  end

# build find method
# if you save, you 
# you need to teach a student instance to know if it has been saved already

# END RESULT
# Studen


end

#

erin = Student.new("Erin", "tagline")
erin.save
eugene = Student.new("Eugene", "hello")
eugene.save
harrison = Student.new("Harrison", "what")
harrison.save










###

# module SQLizer

#   module ClassMethod
#     # Check if database exists
#     # Create database if database does not exist
#     # 
#   end

#   module InstanceMethod
#   end

# end


# if !File.exist?("students.db")
#   db = SQLite3::Database.new "students.db"
# end

# rows = db.execute <<-SQL
#   CREATE TABLE names(
#     id INTEGER PRIMARY KEY autoincrement,
#     name varchar(30)
#   );
# SQL

# rows = db.execute <<-SQL
#   create table taglines(
#     id INTEGER PRIMARY KEY autoincrement,
#     description text,
#     student_id varchar(20),
#     FOREIGN KEY(student_id) REFERENCES names(id)
#   );
# SQL

# rows = db.execute <<-SQL
#   create table intros(
#     id INTEGER PRIMARY KEY autoincrement,
#     description text,
#     student_id varchar(20),
#     FOREIGN KEY(student_id) REFERENCES names(id)
#   );
# SQL

# rows = db.execute <<-SQL
#   create table aspirations(
#     id INTEGER PRIMARY KEY autoincrement,
#     description text,
#     student_id varchar(20),
#     FOREIGN KEY(student_id) REFERENCES names( 
# SQL

# rows = db.execute <<-SQL
#   create table interests(
#     id INTEGER PRIMARY KEY autoincrement,
#     description text,
#     student_id varchar(20),
#     FOREIGN KEY(student_id) REFERENCES names(id)
#   );
# SQL

# rows = db.execute <<-SQL
#   create table social_pages(
#     id INTEGER PRIMARY KEY autoincrement,
#     description text,
#     student_id varchar(20),
#     FOREIGN KEY(student_id) REFERENCES names(id)
#   );
# SQL

# rows = db.execute <<-SQL
#   create table prev_work(
#     id INTEGER PRIMARY KEY autoincrement,
#     description text,
#     student_id varchar(20),
#     FOREIGN KEY(student_id) REFERENCES names(id)
#   );
# SQL

# rows = db.execute <<-SQL
#   create table education(
#     id INTEGER PRIMARY KEY autoincrement,
#     description text,
#     student_id varchar(20),
#     FOREIGN KEY(student_id) REFERENCES names(id)
#   );
# SQL

# rows = db.execute <<-SQL
#   create table coder_cred(
#     id INTEGER PRIMARY KEY autoincrement,
#     description text,
#     student_id varchar(20),
#     FOREIGN KEY(student_id) REFERENCES names(id)
#   );
# SQL

# rows = db.execute <<-SQL
#   create table fave_apps(
#     id INTEGER PRIMARY KEY autoincrement,
#     description text,
#     student_id varchar(20),
#     FOREIGN KEY(student_id) REFERENCES names(id)
#   );
# SQL

# rows = db.execute <<-SQL
#   create table companies(
#     id INTEGER PRIMARY KEY autoincrement,
#     description text,
#     student_id varchar(20),
#     FOREIGN KEY(student_id) REFERENCES names(id)
#   );
# SQL

# class Student
  
#   attr_accessor(
#     :url,
#     :name,
#     :tagline,
#     :intro,
#     :aspiration,
#     :fave_apps,
#   )

#   ATTRIBUTES = {
#     :name => :text,
#     :tagline => :text,
#     :intro => :text,
#     :aspiration => :text,
#     :interests => :text,
#     :social_pages => :text,
#     :education => :text,
#     :fave_apps => :text,
#     :companies => :text
#   }

#   def self.attributes
#     ATTRIBUTES.keys
#   end

#   def self.attributes_hash
#     ATTRIBUTES
#   end

#   @@db = SQLite3::Database.new "students.db"
#   @@student_list_url = []

#   def initialize(url)
#     @url = url
#     @@student_list_url << self.url
#   end

#   def student_links
#   end

#   def self.list
#     @@student_list_url
#   end

#   def self.count
#     "There are #{@@student_list.size} students in the class"
#   end

#   def self.table_name
#     "students"
#   end

#   def create_table_sql
#   end

#   def self.columns_for_sql
#     self.attributes.collect { |k, v| "#{k.to_s.downcase} #{v.to_s.upcase}" }.join
#   end

#   def self.create_table
#     @@db.execute("CREATE TABLE ? (
#       ATTRIBUTES.collect { |k, v| #{k.to_s.downcase} #{v.to_s.upcase}}
#       )")
#   end

#   #   create table companies(
#   #   id INTEGER PRIMARY KEY autoincrement,
#   #   description text,
#   #   student_id varchar(20),
#   #   FOREIGN KEY(student_id) REFERENCES names(id)
#   # )

#   def values_for_attributes_for_sql
#     self.attributes_hash.collect { |a| self.send(a) }
#   end

#   def attributes_for_sql
#   end

#   def question_marks_for_sql

#   end

#   def insert_for_sql
#     "INSERT INTO ? (#{attributes_for_sql}) VALUES (#{question_marks_for_sql})", [self.table_name]["#{values_for_attributes_for_sql}"]
#   end

#   def save_for_sql
#   end

#   def save_name
#     @@db.execute(
#       "INSERT INTO names (id, name)
#       VALUES (?, ?)", [@@student_list_url.size.to_i, self.name]);
#   end

#   def save_tagline
#     @@db.execute(
#       "INSERT INTO taglines (id, description, student_id)
#       VALUES (?, ?, ?)", [@@student_list_url.size.to_i, self.tagline, @@student_list_url.size.to_i]);
#   end

#   def save_intro
#     @@db.execute(
#       "INSERT INTO intros (id, description, student_id)
#       VALUES (?, ?, ?)", [@@student_list_url.size.to_i, self.intro, @@student_list_url.size.to_i]);
#   end

#   def save_aspiration
#     @@db.execute(
#       "INSERT INTO aspirations (id, description, student_id)
#       VALUES (?, ?, ?)", [@@student_list_url.size.to_i, self.aspiration, @@student_list_url.size.to_i]);
#   end

#   def save_interest
#     @@db.execute(
#       "INSERT INTO interests (id, description, student_id)
#       VALUES (?, ?, ?)", [@@student_list_url.size.to_i, self.interest, @@student_list_url.size.to_i]);
#   end

#   def save_social_page
#     @@db.execute(
#       "INSERT INTO social_pages (id, description, student_id)
#       VALUES (?, ?, ?)", [@@student_list_url.size.to_i, self.social_page, @@student_list_url.size.to_i]);
#   end

#   def save_prev_work
#     i = 1
#     self.prev_work.each do |work|
#       @@db.execute(
#         "INSERT INTO prev_work (id, description, student_id)
#         VALUES (?, ?, ?)", [("#{@@student_list_url.size.to_i}" + "#{i}").to_i, work, @@student_list_url.size.to_i]);
#       i += 1
#     end
#   end

#   def save_education
#     i = 1
#     self.education.each do |educ|
#       @@db.execute(
#         "INSERT INTO education (id, description, student_id)
#         VALUES (?, ?, ?)", [("#{@@student_list_url.size.to_i}" + "#{i}").to_i, educ, @@student_list_url.size.to_i]);
#       i += 1
#     end
#   end

#   def save_coder_cred
#     @@db.execute(
#       "INSERT INTO coder_cred (id, description, student_id)
#       VALUES (?, ?, ?)", [@@student_list_url.size.to_i, self.coder_cred, @@student_list_url.size.to_i]);
#   end

#   def save_fave_app
#     i = 1
#     self.fave_app.each do |app|
#       @@db.execute(
#         "INSERT INTO fave_apps (id, description, student_id)
#         VALUES (?, ?, ?)", [("#{@@student_list_url.size.to_i}" + "#{i}").to_i, app, @@student_list_url.size.to_i]);
#       i += 1
#     end
#   end

#   def save_companies
#     @@db.execute(
#       "INSERT INTO companies (id, description, student_id)
#       VALUES (?, ?, ?)", [@@student_list_url.size.to_i, self.companies, @@student_list_url.size.to_i]);
#   end

#   def get_student_attributes_by_url
#     self.name
#     self.tagline
#     self.intro
#     self.aspiration
#     self.interest
#     self.social_page
#     self.prev_work
#     self.education
#     self.coder_cred
#     self.fave_app
#     self.companies
#   end

#   def save_student_attributes_by_url
#     self.save_name
#     self.save_tagline
#     self.save_intro
#     self.save_aspiration
#     self.save_interest
#     self.save_social_page
#     self.save_prev_work
#     self.save_education  
#     self.save_coder_cred
#     self.save_fave_app  
#     self.save_companies
#   end

#   # GET INSTANCE ATTRIBUTE METHODS

#   # def get_name
#   # end

#   # def get_tagline
#   # end

#   # def get_intro
#   # end

#   # etc.

# end

# url = "http://students.flatironschool.com"

# def index_links(target_link) # Index all target links within target URL
#   student_links = Array.new
#   document = Nokogiri::HTML(open(target_link)) # Pass in target URL
#   target = '.one_third a:first'
#   document.css(target).each do |item| # Loop to create an array of all student page links
#     profile_link = ""
#     if item.attributes["href"].to_s.start_with?("./") || (item.attributes["href"].to_s.end_with?("html") || item.attributes["href"].to_s.end_with?("htm")) == false # Exclude improperly formatted URLs
#       profile_link = ""
#     else
#       profile_link = item.attributes["href"]
#       student_links << "http://students.flatironschool.com/" + profile_link.to_s.chomp
#     end
#   end
#   student_links
# end

# index_links(url).each do |link|
#   student = Student.new(link)
#   student.get_student_attributes_by_url
#   student.save_student_attributes_by_url
#   # student.name
#   # student.save_name
#   # student.tagline
#   # student.save_tagline
#   # student.intro
#   # student.save_intro
#   # student.aspiration
#   # student.save_aspiration
#   # student.interest
#   # student.save_interest
#   # student.social_page
#   # student.save_social_page
#   # student.prev_work
#   # student.save_prev_work
#   # student.education
#   # student.save_education  
#   # student.coder_cred
#   # student.save_coder_cred
#   # student.fave_app
#   # student.save_fave_app  
#   # student.companies
#   # student.save_companies
# end

# puts "Done"



# # TEST CODE

#   # def name
#   #   begin
#   #     document = Nokogiri::HTML(open(url))
#   #     document.css(".two_third h1").text
#   #   rescue
#   #   end
#   # end

#   # def tagline
#   #   begin
#   #     document = Nokogiri::HTML(open(url))
#   #     document.css(".two_third h2").text
#   #   rescue
#   #   end
#   # end

#   # def intro
#   #   begin
#   #     document = Nokogiri::HTML(open(url))
#   #     document.css(".two_third p:first").text
#   #   rescue
#   #   end
#   # end

#   # def aspiration
#   #   begin
#   #     document = Nokogiri::HTML(open(url))
#   #     document.css(".two_third h3 + p").text
#   #   rescue
#   #   end
#   # end

#   # def interest
#   #   begin
#   #     document = Nokogiri::HTML(open(url))
#   #     document.css(".two_third h3:last + p").text
#   #   rescue
#   #   end
#   # end

#   # def social_page
#   #   begin
#   #     document = Nokogiri::HTML(open(url))
#   #     document.css(".social_icons li a.attributes['href']").text
#   #   rescue
#   #   end
#   # end

#   # def prev_work
#   #   prev_work_array = []
#   #   begin
#   #     document = Nokogiri::HTML(open(url))
#   #     prev_work_list = document.css(".one_half:first li")
#   #     prev_work_list.each do |item|
#   #       prev_work_array << item.text
#   #     end
#   #   rescue
#   #   end
#   #   prev_work_array
#   # end

#   # def education
#   #   education_array = []
#   #   begin
#   #     document = Nokogiri::HTML(open(url))
#   #     education_list = document.css(".one_half:nth-child(2) li")
#   #     education_list.each do |item|
#   #       education_array << item.text
#   #     end
#   #   rescue
#   #   end
#   #   education_array
#   # end

#   # def coder_cred
#   #   begin
#   #     document = Nokogiri::HTML(open(url))
#   #     document.css("td a").text
#   #   rescue
#   #   end
#   # end

#   # def fave_app
#   #   fave_app_array = []
#   #   begin
#   #     document = Nokogiri::HTML(open(url))
#   #     fave_app_list = document.css("#favorites .columns .one_third figcaption")
#   #     fave_app_list.each do |app|
#   #       fave_app_array << app.text
#   #     end
#   #   rescue
#   #   end
#   #   fave_app_array
#   # end

#   # def companies
#   #   begin
#   #     document = Nokogiri::HTML(open(url))
#   #     document.css("#favorites .columns:last .one_third figcaption").text
#   #   rescue
#   #   end
#   # end

# # SCRAPER

# # url = "http://students.flatironschool.com"

# # $criteria = [ # Array of scraper criteria - key and selector
# #   [:tagline, ".two_third h2"]
# #   # [:introduction, ".two_third p:first"]
# #   # [:aspirations, ".two_third h3 + p"]
# #   # [:interests, ".two_third h3:last + p"],
# #   # [:social_pages, ".social_icons li a"],
# #   # [:prev_work, ".one_half:first li"],
# #   # [:education, ".one_half:nth-child(2) li:first"],
# #   # [:coder_cred, "td a"],
# #   # [:fave_apps, "#favorites .columns .one_third figcaption"],
# #   # [:companies, "#favorites .columns:last .one_third figcaption"]
# # ]

# # def index_links(target_link) # Index all target links within target URL
# #   student_links = Array.new
# #   document = Nokogiri::HTML(open(target_link)) # Pass in target URL
# #   target = '.one_third a:first'
# #   document.css(target).each do |item| # Loop to create an array of all student page links
# #     profile_link = ""
# #     if item.attributes["href"].to_s.start_with?("./") || (item.attributes["href"].to_s.end_with?("html") || item.attributes["href"].to_s.end_with?("htm")) == false # Exclude improperly formatted URLs
# #       profile_link = ""
# #     else
# #       profile_link = item.attributes["href"]
# #       student_links << "http://students.flatironschool.com/" + profile_link.to_s.chomp
# #     end
# #   end
# #   student_links
# # end

# # def print_links(array) # Print all links that are being parsed
# #   i = 0
# #   array.each do
# #     puts "Parsing ... " + "#{array[i]}"
# #     i += 1
# #   end
# # end

# # # Get student name

# # def parse_links(index) # Parse data returned from each separate page
# #   page_targets_hash = Hash.new
# #   index.each do |link|
# #     begin 
# #       document = Nokogiri::HTML(open(link))
# #       name = ".two_third h1"
# #       document.css(name).each do |student|
# #         page_targets_hash[student.text] ||= {}
# #         $criteria.each do |label, item|
# #           document.css("#{item}").each do |tag|
# #             input = ""
# #             if tag.attributes["href"] == nil 
# #               input = tag.text
# #             else
# #               input = tag.attributes["href"].text
# #             end
# #             page_targets_hash[student.text][label] ||= []
# #             page_targets_hash[student.text][label] << input
# #           end
# #         end
# #       end
# #     rescue # Skip link if Open-URI is unable to parse URL
# #     end
# #   end
# #   page_targets_hash
# # end

# # def run_scrape(site) # Run scraper methods
# #   parse_links(index_links(site))
# # end

# # def print_scrape(hash) # Print scraper results
# #   hash.each do |name, description|
# #     puts "#{name}: #{description}"
# #     puts ""
# #   end
# # end

# # # print_links(index_links(url))
# # # print_scrape(run_scrape(url))

# # i = 1
# # run_scrape(url).each do |name, hash|
# #   first_name = name.to_s.split[0].downcase
# #   student = Student.new(name, ha0][":tagline"])
# #   db.execute(
# #     "INSERT INTO names (id, name)
# #     VALUES (?, ?)", [i, student.name]);
# #   db.execute(
# #     "INSERT INTO taglines (id, description, student_id)
# #     VALUES (?, ?, ?)", [i, student.tagline, i]);
# #     # db.execute(
# #     #   "INSERT INTO introductions (id, description, student_id)
# #     #   VALUES (?, ?, ?)", [i, student.introduction, i]);
# #     # db.execute(
# #     #   "INSERT INTO aspirations (id, description, student_id)
# #     #   VALUES (?, ?, ?)", [i, student.aspiration, i]);
# #   i += 1
# # end

# # puts Student.list


# # SCHEMA

# # TABLES

# # 1) students
# #   a) id 
# #   b) name

# # 2) taglines
# #   a) id 
# #   b) description
# #   c) student_id

# # 3) introductions
# #   a) id 
# #   b) description
# #   c) student_id

# # 4) aspirations
# #   a) id 
# #   b) description
# #   c) student_id

# # 5) interests
# #   a) id 
# #   b) description
# #   c) student_id

# # 6) social_pages
# #   a) id 
# #   b) description
# #   c) link
# #   d) student_id

# # 7) prev_work
# #   a) id 
# #   b) description
# #   c) student_id

# # 7) education
# #   a) id 
# #   b) description
# #   c) student_id

# # 8) coder_cred
# #   a) id 
# #   b) description
# #   c) student_id

# # 9) fave_apps
# #   a) id 
# #   b) description
# #   c) link
# #   d) student_id

# # 10) companies
# #   a) id 
# #   b) description
# #   c) student_id

# # test_hash = {
# #   "Ana Asnes Becker"=>{}, 
# #   "Ciara Burkett"=>{}, 
# #   "Laura Brown"=>{}, 
# #   "Andrew Callahan"=>{}, 
# #   "Christina Chang"=>{}, 
# #   "Crystal Chang"=>{}, 
# #   "Tyler Davis"=>{}, 
# #   "John Kelly Ferguson"=>{}, 
# #   "Alex Gorski"=>{}, 
# #   "Tim Hunter"=>{}, 
# #   "Eric Iacutone"=>{}, 
# #   "Yanik Jayaram"=>{}, 
# #   "Cho Kim"=>{}, 
# #   "Jesse La Russo"=>{}, 
# #   "Erin Lee"=>{}, 
# #   "Danny Olinsky"=>{}, 
# #   "Rahul Seshan"=>{}, 
# #   "Jane Vora"=>{}, 
# #   "Harrison Wang"=>{}, 
# #   "Anthony"=>{}
# # }
