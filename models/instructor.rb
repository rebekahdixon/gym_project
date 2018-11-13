require_relative( '../db/sql_runner' )
require('pry-byebug')

class Instructor

  attr_accessor(:name, :id)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
  sql = "INSERT INTO instructors
  (name)
  VALUES
  ($1)
  RETURNING id"
  values = [@name]
  results = SqlRunner.run(sql, values)
  @id = results.first()['id'].to_i
end

def update()
  sql = "UPDATE instructors
  SET
  name =
  $1
  WHERE id = $2"
  values = [@name, @id]
  SqlRunner.run(sql, values)
end

def delete
  sql = "DELETE FROM instructors
  WHERE id = $1"
  values = [@id]
  SqlRunner.run( sql, values )
end

def self.delete_all
  sql = "DELETE FROM instructors"
  SqlRunner.run( sql )
end

def self.all
  sql ="SELECT * FROM instructors"
  results = SqlRunner.run(sql)
  return results.map { |instructor| Instructor.new(instructor) }
end

def self.find(id)
   sql = "SELECT * FROM instructors
   WHERE id = $1"
   values = [id]
   result = SqlRunner.run(sql, values).first
   instructor = Instructor.new(result)
   return instructor
 end

 def sessions
  sql = "SELECT * FROM sessions
  WHERE instructor_id = $1"
  values = [@id]
  results = SqlRunner.run( sql, values )
  sessions = results.map { |session| Session.new(session) }
  return sessions
end

def self.instructors_free(datetime)
sql = "SELECT DISTINCT instructors.*
 FROM instructors, sessions
 WHERE instructors.id NOT IN (SELECT instructor_id FROM sessions WHERE session_datetime = $1)"
 value = [datetime]
 results = SqlRunner.run(sql, value)
 return instructors = results.map { |instructor| Instructor.new(instructor) }
 return instructors
end

end
