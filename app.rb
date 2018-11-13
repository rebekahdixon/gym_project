require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/instructors_controller')
require_relative('controllers/members_controller')
require_relative('controllers/sessions_controller')
require_relative('controllers/bookings_controller')

also_reload( './models/*' )



get '/' do
  erb( :index )
end
