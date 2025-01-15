class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def index
    @users = User.paginate(:page => params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(set_user_params)
    if @user.save
      flash[:notice] = "User was created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @articles = @user.article.paginate(:page => params[:page], per_page: 5)
  end

  def edit
  end

  def update
    if @user.update(set_user_params)
      flash[:notice] = "User was successfully updated."
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_user_params
    params.require(:user).permit(:username, :email, :password)
  end
end