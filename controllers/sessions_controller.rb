# require( 'sinatra' )
# require( 'sinatra/contrib/all' )
require_relative( '../models/session.rb' )
require_relative( '../models/member.rb' )
require_relative( '../models/instructor.rb' )

also_reload( '../models/*' )

#index
get '/sessions' do
  @sessions = Session.all()
  erb ( :"sessions/index" )
end
#new
get '/sessions/new' do
@instructors = Instructor.all
  erb(:"sessions/new")

end

get '/sessions/chooseinstructor/' do
   @capacity = params['capacity']
   @session_name = params['session_name']
   @session_datetime = params['session_datetime']

@instructors = Instructor.instructors_free(params['session_datetime'])
# session = Session.new(params)
# session.save
erb(:"sessions/chooseinstructor")
end


#show
get '/sessions/:id' do
  @session = Session.find(params['id'].to_i)
  erb( :"sessions/show" )
end

#Create
post '/sessions' do
  session = Session.new(params)
  session.save
  redirect to('/sessions')
end

#edit
# get '/sessions/:id/edit' do
#     @session = Session.find(params[:id])
#     erb(:"sessions/edit")
# end
#
# # update
# post '/sessions/:id' do
#   session = Session.new(params)
#   session.update
#   redirect to '/sessions'
# end

# destroy
post '/sessions/:id/delete' do
  @session = Session.find(params['id'])
  @session.delete
  redirect to '/sessions'
end
