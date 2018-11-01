class HomeController < ApplicationController
  def index
    @recipes = Recipe.all
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def search
    @query = params[:q]
    @recipes = Recipe.where 'title like ?', "%#{@query}%"
  end
end
