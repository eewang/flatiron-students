require 'pry'
require 'sqlite3'


class Student
    attr_accessor :name, :tagline, :bio
    
    @@students_list = []

    def initialize
        @name = name
        @tagline = tagline
        @bio = bio
        @@students_list << name
    end

#creating database
    def self.create_db
    @@db = SQLite3::Database.new("students_test.db")
    end

#creating students table
    def self.create_table
    @@db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS students(
        id INTEGER PRIMARY KEY autoincrement,
        name text,
        tagline text,
        bio text
      );
    SQL
    end

    ## this abstracts the student attributes so you can add one anytime

     # def attributes_for_sql
     #     self.class.attributes.join(",") 
     # end

    # def self.find_by_name(name)
    #     rows = @@db.execute("SELECT * FROM students WHERE name = ? Limit 1", name)
    #     result = Student.new
    #     result.name = rows.flatten[0]
    #     result.bio = rows.flatten[1]
    # end

    def save
        @@db.execute("INSERT INTO students (id, name, tagline, bio) 
            VALUES( ?, ?, ?, ? )", [@@students_list.size, @name, @tagline, @bio])
    end
    
    def values_for_db
        values = [@name, @tagline, @bio]
    end



end

Student.create_db
Student.create_table

student = Student.new
student.name = "Ana"
student.bio = "hi."
student.save

#student instance has to know whether or not it's been saved already

# build find_by_name
# get student save to work

# update or new

        # if self.find_by_name(@name)
        #     #update the values in the existing database row
        #     @@db.execute()
        # else
        #     #create a new row with the values from the student instance
        #     @@db.execute()