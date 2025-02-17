class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

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
      session[:user_id] = @user.id
      redirect_to root_path
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

  def destroy
    if @user == current_user
      logout
    end
    @user.destroy
    flash[:notice] = "User was successfully deleted."
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != User.find(params[:id]) && !current_user.admin?
      flash[:alert] = "You don't have sufficient permissions to perform this action."
      redirect_to users_path
    end
  end

end