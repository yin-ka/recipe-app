class RecipeController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipe_index_path, notice: 'Recipe was successfully deleted.'
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.public = recipe_params[:public] == '1'

    if @recipe.save
      redirect_to @recipe, notice: 'Recipe updated successfully.'
    else
      render :edit
    end
  end

  def public_recipes
    @public_recipes = Recipe.where(public: true)
  end
end
