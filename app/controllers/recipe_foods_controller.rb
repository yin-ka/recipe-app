class RecipeFoodsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  before_action :set_recipe

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
  end

  def show
    @recipe_food = RecipeFood.find(params[:id])
  end

def create
  @recipe = Recipe.find(params[:recipe_id])
  @recipe_food = @recipe.recipe_foods.build(recipe_food_params)
  selected_food = Food.find(recipe_food_params[:food_id])
  @recipe_food.food = selected_food

  if @recipe_food.save
    redirect_to recipe_path(@recipe), notice: 'Ingredient was successfully added.'
  else
    puts @recipe_food.errors.full_messages
    render :new
  end
end







  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.destroy
      redirect_to recipe_path(@recipe), notice: 'Ingredient was successfully removed.'
    else
      redirect_to recipe_path(@recipe), alert: 'Failed to remove the ingredient.'
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

def recipe_food_params
  params.require(:recipe_food).permit(:food_id, :quantity, :value, :recipe_id)
end

end