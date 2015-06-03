class NotificationsController < ApplicationController

  def cur_user
    render text: current_user.id.to_s
  end

  def create
    message = "Apples and oranges are super duper megaly awesome fantastic amazing huzzah cool!"

    Pusher.trigger("notifications#{current_user.id}", 'new_notification', {
        message: message
    })
    Notification.create(user_id: current_user.id, content: message, link: "/users/#{current_user.id}")
    render text: "It worked!"
  end

  def index
    @notifications = current_user.get_recent_notifications(50)
  end
end