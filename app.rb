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