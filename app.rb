require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'recipe.rb'
require_relative 'cookbook.rb'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

# [...]

get '/' do
  cookbook = Cookbook.new(File.join(__dir__, 'recipe.csv'))
  @recipes = cookbook.all
  erb :index
end

get '/enter' do
  erb :enter
end

post '/enter' do
 new_recipe = Recipe.new(params["recipe_name"], params["description"])
 cookbook.add_recipe(new_recipe)
 redirect "/"
end

