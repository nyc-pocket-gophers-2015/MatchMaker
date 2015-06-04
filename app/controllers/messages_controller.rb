class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    if @message.save
      Pusher.trigger("chat#{@message.chat_id}", 'new_message', {
          content: @message.content,
          name: @message.user.name,
          chat_id: @message.chat_id,
          url: current_user.find_gravatar_url
      })
      if request.xhr?
        render text: "it worked"
      else
        redirect_to chat_path @message.chat_id
      end
    else
      flash[:warn] = "Unable to send message at this time."
      redirect_to :back
    end
  end

  private
    def message_params
      params.require(:message).permit(:user_id, :content, :chat_id)
    end
end