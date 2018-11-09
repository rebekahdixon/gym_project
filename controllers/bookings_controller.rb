require_relative( '../models/booking.rb' )
require_relative( '../models/class.rb' )
require_relative( '../models/member.rb' )

#index
get '/bookings' do
  @bookings = Booking.all()
  erb ( :"bookings/index" )
end
#new
get '/bookings/new' do
  @members = Member.all
  @sessions = Session.all
  erb(:"bookings/new")
end


#Create
post '/bookings' do
  booking = Booking.new(params)
  booking.save
  redirect to('/bookings')
end

#edit
get '/bookings/:id/edit' do
    @booking = Booking.find(params[:id])
    erb(:"booking/edit")
end

# update
post '/bookings/:id' do
  booking = Booking.new(params)
  booking.update
  redirect to '/bookings'
end

# destroy
post '/bookings/:id/delete' do
  @booking = Booking.find(params['id'])
  @booking.delete
  redirect to '/booking'
end
