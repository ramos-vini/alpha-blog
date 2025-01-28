class CategoriesController < ApplicationController

  def show
  end

  def index
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(set_category_params)
    if @category.save
      flash[:notice] = "Category was created successfully."
      redirect_to @category 
    else 
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_category_params
    params.require(:category).permit(:name)
  end
end