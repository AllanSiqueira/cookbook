class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find params[:id]
  end
  def new
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
    @recipe = Recipe.new
  end
  def create
    @recipe = Recipe.new recipes_params
    if @recipe.save
      redirect_to @recipe
    else
      @cuisines = Cuisine.all
      @recipe_types = RecipeType.all  
      render 'new'
    end
  end

  private

  def recipes_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :cook_method)
  end

end
