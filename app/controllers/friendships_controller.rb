class FriendshipsController < ApplicationController
  def index
    @friends = current_user.all_approved_friends
  end

  def create
    @friendship = Friendship.new(friendship_params)
    if @friendship.save
      redirect_to :back
    else
      flash[:warn] = "Unable to send friend request, please try again"
      redirect_to :back
    end
  end

  def update
    @friendship = Friendship.find_by(id: params[:id])
    if @friendship.update_attributes(friendship_params)
      redirect_to user_path(id: params[:user_id])
    else
      flash[:warn] = "There was an error, please try again"
      redirect_to :back
    end
  end

  def destroy
    @friendship = Friendship.find_by(id: params[:id])
    @friendship.delete
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end