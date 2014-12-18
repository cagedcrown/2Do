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
	# puts params.inspect
	@current_user_id = current_user.id
	@task_title = params[:title]
	@task_body = params[:description]
	@list_id = params[:list_id]
	Task.create(title: @task_title, description: @task_body, list_id: @list_id, user_id: @current_user_id)
	redirect '/lists'
end

get '/:list_id/tasks' do
    @list_id = params[:list_id]
	@tasks = Task.where(list_id: params[:list_id])
	erb :tasks
end

get '/something/:list_id/delete' do
	@delete_list = List.find(params[:list_id])
	@delete_list.destroy
	redirect "/"
end

get '/:list_id/task_added' do
	erb :task_added
end

get '/remove/task/:task_id' do
	@task_id = params[:task_id]
	erb :delete_task_form
end

post '/task_removed' do
	@task_id = params[:task_id]
	Task.destroy(@task_id)
	redirect '/lists'
end

post '/:list_id/tasks' do
	erb :new_task_form
end

get '/list/:list_id/edit' do
	@list = List.find(params[:list_id])
	@list_id = @list.id
	erb :edit_list_form
end

post '/list/:list_id/edit' do
	@update_list = List.find(params[:list_id])
	@update_list.title = params[:title]
	@update_list.body = params[:body]
	@update_list.save
	# List.save(title: @update_title, body: @update_body)
	redirect '/lists'
end

get '/task/:task_id/edit' do
	@task = Task.find(params[:task_id])
	@task_id = @task.id
	erb :edit_task_form
end

post '/task/:task_id/edit' do
	@update_task = Task.find(params[:task_id])
	@update_task.title = params[:title]
	@update_task.description = params[:description]
	@update_task.save
	# List.save(title: @update_title, body: @update_body)
	redirect '/lists'
end


# update_pet_name = params[:pet_name]
# 		update_pet = Pet.find_by(pet_name: update_pet_name)
# 		new_image = params[:new_image]
# 		update_pet.image = new_image
# 		update_pet.save
# 		redirect('/pets')
# 		else
# 		redirect('/')


# delete 'remove/task/:id' do
#   Task.get(params[:id]).destroy
#   redirect to('/')
# end


# get '/current_user' do
# 	@current_user_id = current_user.id
# 	@current_user_email = current_user.email
# 	erb :current_user
# end


# delete lists and tasks


# get '/whatever/:task_id' do
# 	@delete_task = Task.find(params[:task_id])
# 	@delete_task.destroy
# 	erb :tasks
# end

post '/:list_id/tasks/:task_id/delete' do
end

# edit lists and tasks


post '/:list_id/edit' do
end

get '/:list_id/tasks/:task_id/edit' do
end

post '/:list_id/tasks/:task_id/edit' do
end

#####

# class Item < ActiveRecord::Base
# 	has_many :deals, dependent: :destroy 
# 	has_many :vendors, :through => :deals
# 	validates :name, uniqueness: true
# 	validates :name, presence: true

# end

#####

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