# class SessionsController < ApplicationController

# def new
# end

# def create
#   user = User.find_by_email(params[:email])
#     if user && user.authenticate(params[:password])
#       session[:user_id] = user.id
#       redirect_to user_path current_user
#     else
#       redirect_to '/login'
#     end
# end

# def destroy
#   session[:user_id] = nil
#   redirect_to '/login'
# end


class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end

# end
