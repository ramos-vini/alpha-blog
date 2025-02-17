class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You have to be logged in to perform this action."
      redirect_to login_path
    end
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "You don't have sufficient permissions to perform this action."
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
  end

end
