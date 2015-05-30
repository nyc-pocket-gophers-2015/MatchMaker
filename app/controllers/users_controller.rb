class UsersController < ApplicationController
  before_action :require_current_user
  before_action :user_by_id, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      flash[:warn] = "That is not a valid user"
      redirect_to :new
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
    params.require(:user).permit(:name, :password, :email, :birthday, :gender, :location, :picture_url, :bio)
  end

  def user_by_id
    @user = User.find_by(id: params[:id])
  end
end