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
get '/members/:id' do
  @members = Member.find(params['id'].to_i)
  erb( :"members/show" )
end

#Create
post '/members' do
  member = Member.new(params)
  member.save
  redirect to('/members')
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
