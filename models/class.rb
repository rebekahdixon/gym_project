require_relative( '../db/sql_runner' )

class Session

  attr_accessor(:session_name, :session_time, :id)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @session_name = options['session_name']
    @session_time = options['session_time']
  end

  def save()
  sql = "INSERT INTO sessions
  (session_name, session_time)
  VALUES
  ($1, $2)
  RETURNING id"
  values = [@session_name, @session_time]
  results = SqlRunner.run(sql, values)
  @id = results.first()['id'].to_i
end


def update()
  sql = "UPDATE sessions
  SET
  (session_name, session_time) =
  ($1, $2)
  WHERE id = $3"
  values = [@session_name, @session_time, @id]
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
   gym_class = Session.new(result)
   return gym_class
 end

 def members()
   sql = "SELECT members.* FROM members INNER JOIN bookings ON bookings.members_id = members.id WHERE bookings.members_id = $1;"
   values = [@id]
   results = SqlRunner.run(sql, values)
   return results.map { |member| Member.new(member) }
 end

end
