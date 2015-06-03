class FriendshipsController < ApplicationController
  def index
    @friends = current_user.all_approved_friends
  end

  def create
    @friendship = Friendship.new(friendship_params)
    if @friendship.save
      generate_notification(@friendship.friend, "#{@friendship.user.name} just sent you a friend request!")
      redirect_to :back
    else
      flash[:warn] = "Unable to send friend request, please try again"
      redirect_to :back
    end
  end

  def update
    @friendship = Friendship.find_by(id: params[:id])
    if @friendship.update_attributes(friendship_params)
      generate_notification(@friendship.user, "#{@friendship.friend.name} just accepted your friend request!")
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

  def generate_notification(user, message)
    Notification.create(user_id: user.id, content: message)
    Pusher.trigger("notifications#{user.id}", 'new_notification', {
      message: message
    })
  end
end