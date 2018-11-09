require_relative( '../models/member.rb' )
also_reload( '../models/*' )

#index
get '/members' do
  @members = Member.all()
  erb ( :"members/index" )
end
#new
get '/members/new' do

  erb(:"members/new")
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
