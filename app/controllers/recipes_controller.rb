class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find params[:id]
  end
  def new
    @cuisines = Cuisine.all
    @recipe = Recipe.new
  end
  def create
    @recipe = Recipe.new recipes_params
    @recipe.save
    redirect_to recipe_url(@recipe)
  end

  private

  def recipes_params
    params.require(:recipe).permit(:title, :recipe_type, :cuisine_id,:difficulty,
                                  :cook_time, :ingredients, :cook_method)
  end
end
