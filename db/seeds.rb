require_relative( "../models/member.rb" )
require_relative( "../models/class.rb" )
require_relative( "../models/booking.rb" )
# require("pry-byebug")

Booking.delete_all
Session.delete_all
Member.delete_all



member1 = Member.new({'first_name' => 'Rebekah', 'last_name' => 'Dixon'})
member1.save
member2 = Member.new({'first_name' => 'Chris', 'last_name' => 'Wright'})
member2.save
member3 = Member.new({'first_name' => 'Leah', 'last_name' => 'Kerr'})
member3.save

member1.first_name = 'bekah'
member1.update


class1 = Session.new({'session_name' => 'spin', 'session_time' => '08:00'})
class1.save
class2 = Session.new({'session_name' => 'boxing', 'session_time' => '12:00'})
class2.save
class3 = Session.new({'session_name' => 'yoga', 'session_time' => '14:00'})
class3.save

booking1 = Booking.new({'members_id' => member1.id, 'sessions_id' => class1.id})
booking1.save
booking2 = Booking.new({'members_id' => member2.id, 'sessions_id' => class2.id})
booking2.save
booking3 = Booking.new({'members_id' => member3.id, 'sessions_id' => class3.id})
booking3.save

booking2.delete
