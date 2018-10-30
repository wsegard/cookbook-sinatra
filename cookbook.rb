require_relative 'recipe'
require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    extract_recipes_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    # CSV.open(@csv_file_path, "a") do |csv|
    #   csv << [recipe.name, recipe.description]
    # end
    CSV.open(@csv_file_path, "wb") do |csv|
      @recipes.each do |rec|
        csv << [rec.name, rec.description]
      end
    end
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    CSV.open(@csv_file_path, "wb") do |csv|
      @recipes.each do |rec|
        csv << [rec.name, rec.description]
      end
    end
  end

  private

  def extract_recipes_csv
    CSV.foreach(@csv_file_path, 'r') do |row|
      add_recipe(Recipe.new(row[0], row[1])
    end
  end
end
