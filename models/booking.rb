require_relative( '../db/sql_runner' )

class Booking

  attr_accessor(:id, :members_id, :class_id)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @members_id = options['members_id'].to_i
    @classes_id = options['classes_id'].to_i
  end

  def save()
  sql = "INSERT INTO bookings
  (members_id, classes_id)
  VALUES
  ($1, $2)
  RETURNING id"
  values = [@members_id, @classes_id]
  results = SqlRunner.run(sql, values)
  @id = results.first()['id'].to_i
end


def update()
  sql = "UPDATE bookings
  SET
  (members_id, classes_id) =
  ($1, $2)
  WHERE id = $3"
  values = [@members_id, @classes_id, @id]
  SqlRunner.run(sql, values)
end



def self.delete_all
  sql = "DELETE FROM bookings"
  SqlRunner.run( sql )
end

end
