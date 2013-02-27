require 'pry'
require 'net/http'
require 'open-uri'
require 'nokogiri'
require 'sqlite3'

url = "http://students.flatironschool.com"

@doc = Nokogiri::HTML(open("#{url}"))

uri = URI("http://0.0.0.0:9292/index_scrape.rb")

def get_images
  @image_links = @doc.css("img").each do |image|
    puts image.attr("src")
  end
end
