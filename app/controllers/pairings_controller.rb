class PairingsController < ApplicationController
  before_action :require_current_user

  def new
    #find any existing pending_pairings
    @user = User.find_by(id: params[:user_id])
    potential_pairing = @user.find_random_pending_pair_from_friends
    potential_pairing ? @pairing = potential_pairing : @pairing = generate_pair
    unless @pairing
      flash[:warn] = "Unable to generate a new pair. Try adding some friends!"
      redirect_to :back
    end
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @pairing = Pairing.new(pairing_params)
    if @pairing.save
      @match = Match.create(user_id: current_user.id)
      @pairing.update_attributes(match_id: @match.id)
      redirect_to new_pairing_path(user_id: current_user.id)
    else
      flash[:warn] = "Unable to generate a new pair. Try adding some friends!"
      redirect_to :back
    end
  end

  def show
    @pairing = Pairing.find_by(id: params[:id])
  end

  def update
    @pairing = Pairing.find_by(id: params[:id])
    @match_bot = User.find_by(name: "Matchmaker")
    if @pairing.match.update_attributes(matcher_id: current_user.id)
      @match_bot.send_message([@pairing.user, @pairing.pair], "Congrats, You have been matched.", "no subject").conversation
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

  def generate_pair
    users_friends = @user.all_approved_friends
    return nil if users_friends.length < 1
    pair1 = users_friends[rand(0...users_friends.length)]
    pair2 = nil
    #algorithm hereabouts
    until can_be_pair(pair1, pair2)
      pair2 = User.find_by(id: rand(0...User.all.count))
    end
    Pairing.new(user_id: pair1.id, pair_id: pair2.id)
  end

  def can_be_pair(pair1,pair2)
    return false if pair2 == nil
    return false if pair1 == pair2
    return false if pair1.preferred_gender != pair2.gender
    return false if !pair1.preferred_age_range.include?(pair2.age)
    return false if pair2 == @user
    true
  end
end