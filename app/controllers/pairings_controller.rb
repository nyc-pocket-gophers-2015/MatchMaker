class PairingsController < ApplicationController
  before_action :require_current_user

  def new
    #find any existing pending_pairings
    @user = User.find_by(id: params[:user_id])
    pending_pairing = @user.find_random_pending_pair_from_friends
    random_pairing_data = @user.find_random_pair_from_friends
    if random_pairing_data
      random_pairing = Pairing.new(user_id: random_pairing_data[:friend].id, pair_id: random_pairing_data[:pair].id)
    else
      random_pairing = nil
    end
    @pairing = pending_pairing || random_pairing
    if request.xhr?
      respond_to do |format|
        format.html {  render action: "new", layout: false }
      end
    end
    unless @pairing
      flash[:warn] = "Unable to generate a new pair. Try adding some friends!"
      redirect_to root_path
    end
  end

  def create
    @user = User.find_by(id: current_user.id)
    @pairing = Pairing.new(pairing_params)
    if @pairing.save
      @pairing.votes.build(user_id: current_user.id, score: params[:score]).save
      if request.xhr?
        render text: "it worked"
      else
        redirect_to new_pairing_path(user_id: current_user.id)
      end
    else
      flash[:warn] = "Unable to generate a new pair. Try adding some friends!"
      redirect_to root_path
    end
  end

  def show
    @pairing = Pairing.find_by(id: params[:id])
  end

  def update
    @pairing = Pairing.find_by(id: params[:id])
    @match_bot = User.find_by(name: "Matchmaker")
    if @pairing
      @pairing.votes.build(user_id: current_user.id, score: params[:score]).save
      if @pairing.is_approved
        @chat = Chat.create(user_id: @pairing.user.id, chatter_id: @pairing.pair.id)
        @chat.messages.build(user_id: @match_bot.id, content: "Congrats, your friends think you'd both be cute together! Time to prove them right!").save
        generate_notification(@pairing.user, "Congrats, your friends have just matched you with #{@pairing.pair.name}!", "/chats")
        generate_notification(@pairing.pair, "Congrats, your friends have just matched you with #{@pairing.user.name}!", "/chats")
        @pairing.voted_yes.each do |user|
          generate_notification(user, "What do ya know, your suggestion of #{@pairing.user.name} and #{@pairing.pair.name} resulted in a match!", "#")
        end
      end
      # @match_bot.send_message([@pairing.user, @pairing.pair], "Congrats, You have been matched.", "no subject").conversation
      if request.xhr?
        render text: "it worked"
      else
        redirect_to new_pairing_path(user_id: current_user.id)
      end
    else
      flash[:warn] = "Something went wrong, please try again"
      redirect_to :back
    end
  end

  def destroy
    @pairing = Pairing.find_by(id: params[:id])
    @pairing.delete
  end

  private

  def pairing_params
    params.require(:pairing).permit(:user_id, :pair_id)
  end

  def generate_notification(user, message, link)
    Notification.create(user_id: user.id, content: message, link: link)
    Pusher.trigger("notifications#{user.id}", 'new_notification', {
      message: message
    })
  end
end