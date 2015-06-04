class ChatsController < ApplicationController
  def index
    @chats = current_user.all_chats
  end

  def show
    @chat = Chat.find_by_id params[:id]
    @message = Message.new
  end

  def destroy
  end
end