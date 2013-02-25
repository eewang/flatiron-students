#simplescrape.rb
require 'open-uri'
require 'nokogiri'

url = "http://students.flatironschool.com"   #Insert URL in quotes 

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

#---------------Student Class----------#

class Student
  attr_accessor :doc, :name, :tagline, :bio, :aspirations, :interests, :social_links, :prevwork, :education, :codercred, :fave_apps, :companies, :quotes

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
    self.aspirations = doc.css(".two_third h3 + p").text
  end
  
  def scrape_interests
     self.interests = doc.css(".two_third p").text
  end

  def social_links
    self.social_links = (doc.css("div.social_icons a")).collect {|social_link| social_link.attr("href")}
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
    self.codercred = (doc.css("#coder-cred td a")).collect { |codercred| codercred.attr("href")}
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
end

all_students = []

student_links.each do |link|
  begin 
    document = Nokogiri::HTML(open(link))
	rescue
    next
  end

  student = Student.new
  student.doc = document


  all_students << student

  puts student.name
  puts student.scrape_tagline
  puts student.scrape_bio
  puts student.scrape_aspirations
  puts student.scrape_interests
  puts student.social_links
  puts student.scrape_prevwork
  puts student.scrape_education
  puts student.scrape_codercred
  puts student.scrape_fave_apps
  puts student.scrape_companies
  puts student.scrape_quotes
end
