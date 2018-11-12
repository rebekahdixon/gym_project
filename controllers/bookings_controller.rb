require_relative( '../models/booking.rb' )
require_relative( '../models/session.rb' )
require_relative( '../models/member.rb' )

#index
get '/bookings' do
  @bookings = Booking.all()
  erb ( :"bookings/index" )
end
#new
get '/bookings/new' do
  @members = Member.all
  # logic
  @sessions = Session.available_sessions


  erb(:"bookings/new")
end

#Create
post '/bookings' do
  booking = Booking.new(params)
  booking.save
  redirect to('/bookings')
end

# destroy
post '/bookings/:id/delete' do
  @booking = Booking.find(params['id'])
  Booking.delete(params[:id])
  redirect to '/bookings'
end
