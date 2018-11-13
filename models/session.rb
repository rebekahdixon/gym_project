require_relative( '../db/sql_runner' )
require('pry-byebug')
class Session

  attr_accessor(:session_name, :session_time, :id, :capacity, :session_date)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @session_name = options['session_name']
    @session_time = options['session_time']
    @capacity = options['capacity'].to_i
    @session_date = format_date(options['session_date'])
    @instructor_id = options['instructor_id'].to_i
  end

  def save()
  sql = "INSERT INTO sessions
  (session_name, session_time, capacity, session_date, instructor_id)
  VALUES
  ($1, $2, $3, $4, $5)
  RETURNING id"
  values = [@session_name, @session_time, @capacity, @session_date, @instructor_id]
  results = SqlRunner.run(sql, values)
  @id = results.first()['id'].to_i
end


def update()
  sql = "UPDATE sessions
  SET
  (session_name, session_time, capacity, session_date, instructor_id) =
  ($1, $2, $3, $4, $5)
  WHERE id = $6"
  values = [@session_name, @session_time, @capacity, @session_date, @instructor_id, @id]
  SqlRunner.run(sql, values)
end

def delete
  sql = "DELETE FROM sessions
  WHERE id = $1"
  values = [@id]
  SqlRunner.run( sql, values )
end

def self.delete_all
  sql = "DELETE FROM sessions"
  SqlRunner.run( sql )
end

def self.all
  sql ="SELECT * FROM sessions"
  results = SqlRunner.run(sql)
  return results.map { |session| Session.new(session) }
end

def self.find(id)
   sql = "SELECT * FROM sessions
   WHERE id = $1"
   values = [id]
   result = SqlRunner.run(sql, values).first
   session = Session.new(result)
   return session
 end

 def members
   sql = "SELECT members.* FROM members INNER JOIN bookings ON bookings.members_id = members.id WHERE bookings.sessions_id = $1;"
   values = [@id]
   results = SqlRunner.run(sql, values)
   return results.map { |member| Member.new(member) }
 end

def count_members
  # binding.pry
  members.count
end

def session_full?
  if count_members >= @capacity
    return true
  else
    return false
  end
end

def Session.available_sessions
  all_sessions = self.all
  all_sessions.find_all  do |session|
    !session.session_full?
  end
end

def how_many_spaces
  spaces_left = @capacity - count_members
  if spaces_left > 0
    return spaces_left
  else
    return "FULL"
  end
end


def format_date(session_date)
  d = Date.parse(session_date)
  d.strftime("%d/%m/%Y")
end


def instructor()
  sql = "SELECT * FROM instructors
  WHERE id = $1"
  values = [@instructor_id]
  results = SqlRunner.run( sql, values )
  return Instructor.new( results.first )
end


end
