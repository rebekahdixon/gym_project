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

#show
get '/sessions/:id' do
  @sessions = Session.find(params['id'].to_i)
  erb( :"sessions/show" )
end

#Create
post '/sessions' do
  session = Session.new(params)
  session.save
  redirect to('/sessions')
end

#edit
get '/sessions/:id/edit' do
    @session = Session.find(params[:id])
    erb(:"sessions/edit")
end

# update
post '/sessions/:id' do
  session = Session.new(params)
  session.update
  redirect to '/sessions'
end

# destroy
post '/sessions/:id/delete' do
  @session = Session.find(params['id'])
  @session.delete
  redirect to '/sessions'
end
