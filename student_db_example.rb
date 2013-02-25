require 'pry'
require 'sqlite3'


class Student
    attr_accessor :name, :tagline, :bio
    
    @@students_list = []

    def initialize(name="")
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
        id INTEGER PRIMARY KEY AUTOINCREMENT,
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

     def self.students_list_array
        @@students_list
     end

    def self.find_by_name(name)
         rows = @@db.execute("SELECT * FROM students WHERE name = ? Limit 1", name)
         #if the name is empty, return false
         if rows == []
            false
         #if the name exists, return result
        else   
         rows
         # result = Student.new
         # result.name = name 
         # result.name = rows.flatten[1]
         # result.bio = rows.flatten[2]
     end
    end

    def save
        if self.class.find_by_name(@name)
            @@db.execute("INSERT INTO students (name, tagline, bio) 
                VALUES(?, ?, ?)", [@name, @tagline, @bio]);
        else
            raise self.inspect
        #      @@db.execute("UPDATE students SET bio=(?), tagline=(?) WHERE name=(?)", [@bio, @tagline, @name])
        end
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
student.tagline = "awomsome?"
student.save

student = Student.new
student.name = "Alex"
student.tagline = "tagline wut wut"
student.bio = "team awomsome 4lyfe"
student.save

student = Student.new
student.name = "Alex"
student.tagline = "new tagline"
student.bio = "new bio"
student.save

student = Student.new
student.name = "Eugene"
student.tagline = "an awesome tagline"
student.bio = "team awomsome"
student.save


# puts Student.find_by_name("Alex") #=> ['Ana', tagline, bio]

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