class PairingsController < ApplicationController
  before_action :require_current_user

  def create
    @user = User.find_by(id: params[:user_id])
    @pairing = generate_pair
    if @pairing
      redirect_to pairing_path(@pairing)
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
    @match = Match.create(user_id: current_user.id)
    if @pairing.update_attributes(match_id: @match.id)
      redirect_to confirmed_path
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

  # def pairing_params
  #   params.require(:pairing).permit(:user_id, :pair_id)
  # end

  def generate_pair
    users_friends = @user.all_friends
    return nil if users_friends.length < 1
    pair1 = users_friends[rand(0...users_friends.length)]
    pair2 = nil
    #algorithm hereabouts
    until can_be_pair(pair1, pair2)
      pair2 = User.find_by(id: rand(0...User.all.count))
    end
    Pairing.create(user_id: pair1.id, pair_id: pair2.id, match_id: @user.id)
  end

  def generate_pair_pool(user)
  end

  def can_be_pair(pair1,pair2)
    return false if pair2 == nil
    return false if pair1 == pair2
    return false if pair2 == @user
    true
  end
end