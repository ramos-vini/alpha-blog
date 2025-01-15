class SessionController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "You have successfully logged in."
      redirect_to @user
    else
      flash.now[:alert] = "Email and Password do not match."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:alert] = "You have logged out."
    redirect_to root_path
  end
end