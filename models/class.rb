require_relative( '../db/sql_runner' )

class GymClass

  attr_accessor(:class_name, :class_time, :id)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @class_name = options['class_name']
    @class_time = options['class_time']
  end

  def save()
  sql = "INSERT INTO classes
  (class_name, class_time)
  VALUES
  ($1, $2)
  RETURNING id"
  values = [@class_name, @class_time]
  results = SqlRunner.run(sql, values)
  @id = results.first()['id'].to_i
end


def update()
  sql = "UPDATE classes
  SET
  (class_name, class_time) =
  ($1, $2)
  WHERE id = $3"
  values = [@class_name, @class_time, @id]
  SqlRunner.run(sql, values)
end

def delete
  sql = "DELETE FROM classes
  WHERE id = $1"
  values = [@id]
  SqlRunner.run( sql, values )
end

def self.delete_all
  sql = "DELETE FROM classes"
  SqlRunner.run( sql )
end

def self.all
  sql ="SELECT * FROM classes"
  results = SqlRunner.run(sql)
  return results.map { |gym_class| Class.new(gym_class) }
end

def self.find
   sql = "SELECT * FROM classes
   WHERE id = $1"
   values = [@id]
   result = SqlRunner.run(sql, values).first
   gym_class = Class.new(result)
   return gym_class
 end

 def members()
   sql = "SELECT members.* FROM members INNER JOIN bookings ON bookings.members_id = members.id WHERE bookings.members_id = $1;"
   values = [@id]
   results = SqlRunner.run(sql, values)
   return results.map { |member| Member.new(member) }
 end

end
