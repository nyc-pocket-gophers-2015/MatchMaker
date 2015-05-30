class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :authorize, :require_current_user

  def current_user
    @current_user ||= User.find_by_id(session[:user])
  end

  def logged_in?
    current_user != nil
  end

  def require_current_user
    unless current_user
      flash[:warn] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end
end
