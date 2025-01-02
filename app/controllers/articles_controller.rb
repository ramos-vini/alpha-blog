class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.all()
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(set_article_params)
    @article.user_id = 1
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to @article 
    else 
      render :new, status: :unprocessable_entity
    end
  end 

  def edit
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(set_article_params)
      flash[:notice] = "Article was successfully updated."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    if @article.delete()
      flash[:notice] = "Article was successfully deleted."
      redirect_to @article
    else
      render 'index'
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def set_article_params
    params.require(:article).permit(:title, :description)
  end

end