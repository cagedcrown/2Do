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

Sinatra::SimpleAuthentication.configure do |c|
  c.use_password_confirmation = true
end
use Rack::Flash, :sweep => true
register Sinatra::SimpleAuthentication

get '/' do
  login_required
  redirect '/lists'
end

get '/lists' do
	@lists = List.all
	erb :lists
end

get '/new_list' do
	erb :new_list_form
end

post '/new_list_form' do
	@list_title = params[:title]
	@list_body = params[:body]
	List.create(title: @list_title , body: @list_body)
	redirect '/lists'
end

get '/new_task' do
	erb :new_task_form
end

post '/new_task_form' do
	@current_user_id = current_user.id
	@task_title = params[:title]
	@task_body = params[:description]
	@list_id = params[:list_id]
	Task.create(title: @task_title, description: @task_body, list_id: @list_id, user_id: @current_user_id)
	redirect '/lists'
end

get '/:list_id/tasks' do
	@list_title = List.find(params[:list_id])
    @list_id = params[:list_id]
	@tasks = Task.where(list_id: params[:list_id])
	erb :tasks
end

get '/something/:list_id/delete' do
	@delete_list = List.find(params[:list_id])
	@delete_list.destroy
	redirect "/"
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
	redirect '/lists'
end