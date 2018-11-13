require('minitest/autorun')
require('minitest/rg')
require_relative('../session')

class SessionSpec < MiniTest::Test
  Booking.delete_all
  Session.delete_all
  Member.delete_all

  instructor1= Instructor.new({'name' => 'Colin'})
  instructor1.save()
  instructor2= Instructor.new({'name' => 'Rachel'})
  instructor2.save()
  instructor3= Instructor.new({'name' => 'Andy'})
  instructor3.save()

  member1 = Member.new({'first_name' => 'Rebekah', 'last_name' => 'Dixon'})
  member1.save
  member2 = Member.new({'first_name' => 'Chris', 'last_name' => 'Wright'})
  member2.save
  member3 = Member.new({'first_name' => 'Leah', 'last_name' => 'Kerr'})
  member3.save

  member1.first_name = 'bekah'
  member1.update


  class1 = Session.new({'session_name' => 'spin', 'session_datetime' => '2018-11-12T08:00', 'capacity' => '20', 'instructor_id' => instructor1.id})
  class1.save
  class2 = Session.new({'session_name' => 'boxing', 'session_datetime' => '2018-11-15T12:00', 'capacity' => '20', 'instructor_id' => instructor2.id})
  class2.save
  class3 = Session.new({'session_name' => 'yoga', 'session_datetime' => '2018-11-14T14:00', 'capacity' => '1', 'instructor_id' => instructor3.id})
  class3.save

  booking1 = Booking.new({'members_id' => member1.id, 'sessions_id' => class1.id})
  booking1.save
  booking2 = Booking.new({'members_id' => member2.id, 'sessions_id' => class2.id})
  booking2.save
  booking3 = Booking.new({'members_id' => member3.id, 'sessions_id' => class3.id})
  booking3.save


def test_instructor_booked_for_session
  expected = true
  actual =
  assert_equal(expected, actual)
end


end
