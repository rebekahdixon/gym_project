# require( 'sinatra' )
# require( 'sinatra/contrib/all' )
require_relative( '../models/member.rb' )
also_reload( '../models/*' )

get '/members' do
  @members = Member.all()
  erb ( :"member/index" )
end

get '/members/new' do
  @members = Members.all
  erb(:"members/new")
end

get '/members/:id' do
  @members = Member.find(params['id'].to_i)
  erb( :"members/show" )
end

post '/members' do
  member = Member.new(params)
  member.save
  redirect to("/members")
end
