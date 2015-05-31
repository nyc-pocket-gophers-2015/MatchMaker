class MessagesController < ApplicationController
  before_action :require_current_user

  def new
  end

  def create
    recipients = User.where(id: params['recipients'])
    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
  end

  # mm.send_message(users, "Congrats, You have been matched.", "no subject").conversation
end