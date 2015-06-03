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
    unless @pairing
      flash[:warn] = "Unable to generate a new pair. Try adding some friends!"
      redirect_to root_path
    end
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @pairing = Pairing.new(pairing_params)
    if @pairing.save
      @pairing.votes.build(user_id: current_user.id, score: params[:score]).save
      redirect_to new_pairing_path(user_id: current_user.id)
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
    # @match_bot = User.find_by(name: "Matchmaker")
    if @pairing
      @pairing.votes.build(user_id: current_user.id, score: params[:score]).save
      if @pairing.is_approved
        trigger_pairing_notification(@pairing.user, @pairing.pair)
        trigger_pairing_notification(@pairing.pair, @pairing.user)
      end
      # @match_bot.send_message([@pairing.user, @pairing.pair], "Congrats, You have been matched.", "no subject").conversation
      redirect_to new_pairing_path(user_id: current_user.id)
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

  def trigger_pairing_notification(user, pair)
    Pusher.trigger("notifications#{user.id}", 'new_notification', {
      message: "You have been matched with #{pair.name}"
    })
  end
end