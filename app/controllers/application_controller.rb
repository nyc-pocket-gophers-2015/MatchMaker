class ApplicationController < ActionController::Base
  before_action :create_timestamp
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :authorize, :require_current_user

  def require_current_user
    unless current_user
      flash.now[:warn] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

    def create_timestamp
      @current_timestamp = Time.now.to_i
    end
end
