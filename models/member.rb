require_relative( '../db/sql_runner' )
require('pry-byebug')

class Member

  attr_accessor(:first_name, :last_name, :member_type, :id)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']

  end

  def save()
  sql = "INSERT INTO members
  (first_name, last_name)
  VALUES
  ($1, $2)
  RETURNING id"
  values = [@first_name, @last_name]
  results = SqlRunner.run(sql, values)
  @id = results.first()['id'].to_i
end

def update()
  sql = "UPDATE members
  SET
  (first_name, last_name ) =
  ($1, $2)
  WHERE id = $3"
  values = [@first_name, @last_name, @id]
  SqlRunner.run(sql, values)
end

def delete
  sql = "DELETE FROM members
  WHERE id = $1"
  values = [@id]
  SqlRunner.run( sql, values )
end

def self.delete_all
  sql = "DELETE FROM members"
  SqlRunner.run( sql )
end

def self.all
  sql ="SELECT * FROM members"
  results = SqlRunner.run(sql)
  return results.map { |member| Member.new(member) }
end

def self.find(id)
   sql = "SELECT * FROM members
   WHERE id = $1"
   values = [id]
   result = SqlRunner.run(sql, values).first
   member = Member.new(result)
   return member
 end

 def format_name
  return "#{@first_name.capitalize} #{@last_name.capitalize}"
end

def classes()
  sql = "SELECT sessions.* FROM sessions INNER JOIN bookings ON bookings.sessions_id = sessions.id WHERE bookings.sessions_id = $1;"
  values = [@id]
  results = SqlRunner.run(sql, values)
  return results.map { |gym_class| Session.new(gym_glass) }
end
end
