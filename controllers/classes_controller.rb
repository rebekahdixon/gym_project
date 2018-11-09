# require( 'sinatra' )
# require( 'sinatra/contrib/all' )
require_relative( '../models/class.rb' )
also_reload( '../models/*' )

get '/classes' do
  @classes = GymClass.all()
  erb ( :"class/index" )
end
