class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find params[:id]
  end
  def new
    @recipe = Recipe.new
  end
  def create
    @recipe = Recipe.new
    @recipe.title = params[:recipe][:title]
    @recipe.recipe_type = params[:recipe][:recipe_type]
    @recipe.ingredients = params[:recipe][:ingredients]
    @recipe.method = params[:recipe][:method]
    @recipe.cuisine = params[:recipe][:cuisine]
    @recipe.difficulty = params[:recipe][:difficulty]
    @recipe.cook_time = params[:recipe][:cook_time]
    @recipe.save
    redirect_to recipe_url(@recipe)
  end
end
