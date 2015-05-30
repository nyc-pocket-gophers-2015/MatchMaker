class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :require_current_user

  def current_user
    User.find_by(id: session[:user_id])
  end

  def require_current_user
    unless current_user
      flash[:warn] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end
end
