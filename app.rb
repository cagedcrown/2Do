# Requiring the basics for Sinatra to work
require 'sinatra'
require 'sinatra/reloader'
# sinatra/activerecord allows us to run rake migrations
require 'sinatra/activerecord'
# sinatra/simple-authentication is the authentication gem
require 'sinatra/simple-authentication'
# rack-flash is how we can use flash messages
require 'rack-flash'

# We need our user model, plus the environments file to connect to the database
require_relative './models/user'
require_relative './models/list'
require_relative './models/task'
require_relative './config/environments'

# Setting configuration options on our authentication gem
Sinatra::SimpleAuthentication.configure do |c|
  c.use_password_confirmation = true
end

# Telling the app to use Rack::Flash
use Rack::Flash, :sweep => true

# Telling the app to use SimpleAuthentication
register Sinatra::SimpleAuthentication

# Our first route
get '/' do
  # Require a login to enter this route, otherwise go to the login page
  login_required
  erb :index
end

get '/lists' do
	@lists = List.all
	erb :lists
end


get '/new_list' do
	erb :new_list_form
end


post '/new_list' do
	
end

# get '/:list_title/tasks' do
# 	erb :
# end


get '/new_thing/:thing' do

	@whatever_we_want = params[:thing]
	erb :someview
end

post '/new_list_form' do
	@list_title = params[:title]
	@list_body = params[:body]
	List.create(title: @list_title , body: @list_body)
	erb :lists
	# redirect '/lists'
end








# #setting up the index route
# get '/' do
#   # @users = User.all
#   "testing"
#   # erb :index
# end

#setting up the form view
# get '/new' do 
#   erb :new_form
# end

#setting up the post route for our form
# post '/new' do
#   @user = User.new(title: params[:title], desc: params[:desc])
#   if @item.save
#     redirect '/'
#   else
#     @errors = @item.errors.full_messages
#     render '/new'
#   end
# end