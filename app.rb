require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'sinatra/simple-authentication'
require 'rack-flash'

require_relative './models/user'
require_relative './models/list'
require_relative './models/task'
require_relative './config/environments'

Sinatra::SimpleAuthentication.configure do |c|
  c.use_password_confirmation = true
end
use Rack::Flash, :sweep => true
register Sinatra::SimpleAuthentication

get '/' do
  login_required
  redirect '/lists'
  # erb :index
end

get '/lists' do
	@lists = List.all
	erb :lists
end

# able to view all lists and create a list on the same page
get '/new_list' do
	erb :new_list_form
end

post '/new_list_form' do
	@list_title = params[:title]
	@list_body = params[:body]
	List.create(title: @list_title , body: @list_body)
	redirect '/lists'
end

# able to view tasks within a form
post '/new_task_form' do
	Task.create(title: @list_title , body: @list_body)
end

get '/:list_id/tasks' do
	erb :new_task
end

post '/list_id/tasks' do

end

get ':list_id/tasks' do
	@task = Task.find(where task_id: params[:list_id])
	erb :tasks
end

# get '/:list_title/tasks' do
# 	erb :
# end


# get '/new_thing/:thing' do
# 	@whatever_we_want = params[:thing]
# 	erb :someview
# end

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