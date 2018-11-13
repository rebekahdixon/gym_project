require_relative( '../models/instructor.rb' )
also_reload( '../models/*' )

#index
get '/instructors' do
  @instructors = Instructor.all()
  erb ( :"instructors/index" )
end
#new
get '/instructors/new' do
  @sessions = Session.all
  @instructors = Instructor.all
  erb(:"instructors/new")
end

#show
get '/instructors/:id' do
  @instructor = Instructor.find(params['id'].to_i)
  erb( :"instructors/show" )
end

#Create
post '/instructors' do
  instructor = Instructor.new(params)
  instructor.save
  redirect to('/instructors')
end

#edit
get '/instructors/:id/edit' do
    @instructor = Instructor.find(params[:id])
    erb(:"instructors/edit")
end

# update
post '/instructors/:id' do
  instructor = Instructor.new(params)
  instructor.update
  redirect to '/instructors'
end

# destroy
post '/instructors/:id/delete' do
  @instructor = Instructor.find(params['id'])
  @instructor.delete
  redirect to '/instructors'
end
