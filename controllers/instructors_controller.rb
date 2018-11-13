require_relative( '../models/instructor.rb' )
also_reload( '../models/*' )

#index
get '/instructors' do
  @instructors = Instructor.all()
  erb ( :"instructors/index" )
end
#new
get '/instructors/new' do

  erb(:"instructors/new")
end

#show
get '/instructors/:id' do
  @instructors = Instructor.find(params['id'].to_i)
  erb( :"instructors/show" )
end

#Create
post '/instructors' do
  instructor = Instructor.new(params)
  instructor.save
  redirect to('/instructors')
end

#edit
get '/members/:id/edit' do
    @member = Member.find(params[:id])
    erb(:"members/edit")
end

# update
post '/members/:id' do
  member = Member.new(params)
  member.update
  redirect to '/members'
end

# destroy
post '/members/:id/delete' do
  @member = Member.find(params['id'])
  @member.delete
  redirect to '/members'
end
