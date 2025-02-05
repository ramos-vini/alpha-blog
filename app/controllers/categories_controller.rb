class CategoriesController < ApplicationController

  before_action :require_admin, except: [:show, :index]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def show
    @articles = @category.articles.paginate(:page => params[:page], per_page: 5)
  end

  def index
    @categories = Category.paginate(:page => params[:page], per_page: 5)
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

  def edit
  end

  def update
    if @category.update(set_category_params)
      flash[:notice] = "Category was successfully updated."
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "Category was successfully deleted."
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def set_category_params
    params.require(:category).permit(:name)
  end
end