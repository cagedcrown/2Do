# require "sinatra"
# require "sinatra/activerecord"
# require "active_record"
# require 'sinatra/simple-authentication'
# require_relative "../config/environments"
# require_relative "../models/user"
# require_relative "../models/task"
# require_relative "../models/list"


# List.create([
 
#   { :title => "Grocery List", :body => "Things we need to get, but we're poor."},
#   { :title => "House Cleaning", :body => "Cleanliness is next to godliness."},
#   { :title => "WDIDC 4 Stuff", :body => "General Assembly"},
# ])

# Task.create([
 
#   { :title => "2 dozen large eggs", :description => "", :list_id => 1, :user_id => 1},
#   { :title => "Paper towels", :description => "", :list_id => 1, :user_id => 1},
#   { :title => "Wheat Bread", :description => "", :list_id => 1, :user_id => 1},
#   { :title => "Steak & cheese", :description => "Get steak & cheese at the Snack N Stand", :list_id => 1, :user_id => 1},
# ])