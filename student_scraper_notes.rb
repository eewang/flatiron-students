class Student
  # Instantiate a new student, regardless of data collection method
  # Save student data to a SQL database
  def initialize(name, tagline)
    @name = name
    @tagline = tagline
  end
end

class Scrape
  # Scrape student website
  # Return attributes of students
end

## DESIRED RESULT ##

Student.new("Alex", "hello")

# OR

Student.new(Scrape.new("Alex URL").name, Scrape.new("Alex URL").tagline)

# For a given class of students, take each student and open the student URL
  # class Student_Scrape
# Scrape the necessary data out of the student page
# Instantiate a Student
# Save data to database for student


## EXAMPLE ##

require 'open-uri'
require 'nokogiri'
require 'sqlite3'
require 'benchmark'
require 'date'

db = SQLite3::Database.new("tickets.db")
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS events(
    id INTEGER PRIMARY KEY autoincrement,
    date_scrape text,
    title varchar(50),
    event_date text,
    venue varchar(30),
    city varchar(20),
    state varchar(2),
    min_price real,
    tix integer
  );
SQL

$entries = db.execute <<-SQL
  SELECT COUNT(title) FROM events;
SQL

class League
  attr_accessor :name
  def self.url
    "http://www.stubhub.com/"
  end

  def self.team_names
    teams = [
      "Atlanta Hawks", 
      "Boston Celtics",
      "Charlotte Bobcats",
      "Chicago Bulls",
      "Cleveland Cavaliers",
      "Dallas Mavericks",
      "Denver Nuggets",
      "Detroit Pistons",
      "Golden State Warriors",
      "Houston Rockets",
      "Indiana Pacers",
      "Los Angeles Clippers",
      "Los Angeles Lakers",
      "Memphis Grizzlies",
      "Miami Heat",
      "Milwaukee Bucks",
      "Minnesota Timberwolves",
      "New Jersey Nets",
      "New Orleans Hornets",
      "New York Knicks",
      "Oklahoma City Thunder",
      "Orlando Magic",
      "Philadelphia 76ers",
      "Phoenix Suns",
      "Portland Trail Blazers",
      "Sacramento Kings",
      "San Antonio Spurs",
      "Toronto Raptors",
      "Utah Jazz",
      "Washington Wizards"
    ]
  end

  def self.team_links
    team_links = self.team_names.collect { |team| self.url + team.downcase.gsub(" ", "-") + "-tickets/" }
  end

  def self.team_name_link_array
    self.team_names.zip(self.team_links)
  end

end


class Team
  attr_accessor :name, :url

  @@teams = []

  # @@selectors = {
  #   event_name = 'tbody a:first span[itemprop = "name performers"]'
  #   event_event_date = 'div .eventDatePadding meta'
  #   event_venue_place = 'div[itemprop = "location"] span[itemprop = "name"]'
  #   event_venue_city = 'div[itemprop = "address"] span[itemprop = "addressLocality"]'
  #   event_venue_state = 'div[itemprop = "address"] span[itemprop = "addressRegion"]'
  #   event_min_price = 'td[itemprop = "offers"] span[itemprop = "lowPrice"]'
  #   event_tix = 'td[itemprop = "offers"] span[itemprop = "offerCount"]'
  # }

  def initialize(name, url)
    @name = name
    @url = url
    @@teams << [self.name, self.url]
  end

  def self.count_teams
    @@teams.size
  end

  def self.name_teams
    @@teams
  end

end

class Event
  
  @@db = SQLite3::Database.new("tickets.db")
  @@events = []

  ATTRIBUTES = {
    :title => :text,
    :event_date => :text,
    :venue => :text,
    :city => :text,
    :state => :text,
    :min_price => :real,
    :tix => :integer,
    # :url => :text
  }

  def self.attributes
    ATTRIBUTES.keys
  end

  self.attributes.each do |attribute|
    attr_accessor attribute
  end

  def attributes_for_sql
    self.class.attributes.join(",")
  end

  def initialize( title, event_date, venue, city, state, min_price, tix) #, url)
    @title = title
    @event_date = event_date
    @venue = venue
    @city = city
    @state = state
    @min_price = min_price
    @tix = tix
    # @url = url
    @@events << [self.title, self.event_date, self.venue, self.city, self.state, self.min_price, self.tix] #, self.url]
  end

  def self.count_events
    @@events.size
  end

  def self.name_events
    @@events
  end

  def self.scrape_date
    (DateTime.now).to_s
  end

  def self.attributes_hash
    ATTRIBUTES
  end

  def self.question_marks_for_sql
    ((["?"]*self.attributes.size).join(", ")).insert(0, "?, ?, ")
  end

  def values_for_attributes_for_sql
    self.class.attributes.collect { |a| self.send(a) }
  end

  def insert_for_sql
    [values_for_attributes_for_sql].flatten
  end

  def save
    @@db.execute(
        "INSERT INTO events (id, date_scrape, #{attributes_for_sql})
        VALUES (#{self.class.question_marks_for_sql})", 
        [$entries.flatten[0] + Event.count_events, Event.scrape_date, insert_for_sql]);
  end

end

League.team_name_link_array.each do |name, url|
  team = Team.new(name, url)
end

Team.name_teams.each do |team, url|
  document = Nokogiri::HTML(open(url))

  event_name = 'tbody a:first span[itemprop = "name performers"]'
  event_event_date = 'div .eventDatePadding'
  event_venue_place = 'div[itemprop = "location"] span[itemprop = "name"]'
  event_venue_city = 'div[itemprop = "address"] span[itemprop = "addressLocality"]'
  event_venue_state = 'div[itemprop = "address"] span[itemprop = "addressRegion"]'
  event_min_price = 'td[itemprop = "offers"] span[itemprop = "lowPrice"]'
  event_tix = 'td[itemprop = "offers"] span[itemprop = "offerCount"]'
  # event_url = ".eventName a"
  i = 0
  document.css(event_name).each do |title|
    event = Event.new(
      title.text, 
      document.css(event_event_date)[i].text, #scrape.event
      document.css(event_venue_place)[i].text, #scrape.venue
      document.css(event_venue_city)[i].text, #
      document.css(event_venue_state)[i].text,
      document.css(event_min_price)[i].text,
      document.css(event_tix)[i].text,
      # document.css(event_url)[i].text
      )
    i += 1
    event.save
  end
end