require 'sinatra'
require 'sinatra/activerecord'
require_relative './models/user'
require_relative './models/list'
require_relative './models/task'
require_relative './config/environments'

#setting up the index route
get '/' do
  @users = User.all
  erb :index
end

#setting up the form view
get '/new' do 
  erb :new_form
end

#setting up the post route for our form
post '/new' do
  @user = User.new(title: params[:title], desc: params[:desc])
  if @item.save
    redirect '/'
  else
    @errors = @item.errors.full_messages
    render '/new'
  end
end