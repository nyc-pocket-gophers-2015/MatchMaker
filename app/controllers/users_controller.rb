class UsersController < ApplicationController
  before_action :require_current_user, except: [:new, :create, :home]
  before_action :user_by_id, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search]
      @users = User.where("lower(name) LIKE ?", "%#{params[:search].downcase}%")
    else
      @users = User.all
    end
  end

  def home
    if current_user
      redirect_to user_path(current_user)
    else
      redirect_to login_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.update_attributes(picture_url: find_gravatar_url)
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:warn] = "That is not a valid user"
      redirect_to new_user_path
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      flash[:warn] = "Could not save updates, please try again"
      redirect_to :edit
    end
  end

  def destroy
    if @user.delete
      flash[:notice] = "User deleted"
      redirect_to root_path
    else
      flash[:warn] = "Could not delete user"
      redirect_to user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :email, :birthday, :gender, :location, :picture_url, :bio, :preferred_gender, :preferred_age_low, :preferred_age_high)
  end

  def user_by_id
    @user = User.find_by(id: params[:id])
  end

  def find_gravatar_url
    hash = Digest::MD5.hexdigest(@user.email)
    return "http://www.gravatar.com/avatar/#{hash}"
  end
end