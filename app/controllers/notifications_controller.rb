class NotificationsController < ApplicationController

  def cur_user
    render text: current_user.id.to_s
  end

  def create
    message = "Apples and oranges are cool!"

    Pusher.trigger("notifications#{current_user.id}", 'new_notification', {
        message: message
    })
    render text: "It worked!"
  end

end