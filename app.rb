require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'sinatra/simple-authentication'
require 'rack-flash'
require 'pry'

require_relative './models/user'
require_relative './models/list'
require_relative './models/task'
require_relative './config/environments'

#binding.pry

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

get '/something/:list_id/delete' do

	@delete_list = List.find(params[:list_id])
	@delete_list.destroy
	# erb :lists
	redirect "/"
	# erb :lists
	# erb :
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
get '/new_task' do
	erb :new_task_form
end

post '/new_task_form' do
	puts params.inspect
	@current_user_id = current_user.id
	@task_title = params[:title]
	@task_body = params[:description]
	@list_id = params[:list_id]
	Task.create(title: @task_title, description: @task_body, list_id: @list_id, user_id: @current_user_id)
end

get '/:list_id/tasks' do
    @list_id = params[:list_id]
	@tasks = Task.where(list_id: params[:list_id])
	erb :tasks
end

get '/:list_id/task_added' do
	erb :task_added
end


post '/:list_id/tasks' do
	erb :new_task_form
end

# get '/current_user' do
# 	@current_user_id = current_user.id
# 	@current_user_email = current_user.email
# 	erb :current_user
# end

# delete lists and tasks


post '/:list_id/delete' do
	# delete lists which matches the selected id key
end

get '/:list_id/tasks/:task_id/delete' do
end

post '/:list_id/tasks/:task_id/delete' do
end

# edit lists and tasks
get '/:list_id/edit' do
end

post '/:list_id/edit' do
end

get '/:list_id/tasks/:task_id/edit' do
end

post '/:list_id/tasks/:task_id/edit' do
end

# 
# get '/users/:username/deals/:deal_id/delete' do
# 	@deal = Deal.find(params[:deal_id])
# 	@deal.destroy
# 	redirect("/users/#{params[:username]}/deals")
# end

# get '/users/:username/purchases' do
# 	@purchases = @current_user.purchases
# 	erb :purchases
# end

# get '/users/:username/purchases/:purchase_id/delete' do
# 	@purchase = Purchase.find(params[:purchase_id])
# 	@purchase.destroy
# 	redirect("/users/#{params[:username]}/purchases")
# end


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