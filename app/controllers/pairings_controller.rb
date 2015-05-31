class PairingsController < ApplicationController
  before_action :require_current_user

  def create
    @pairing = Pairing.new(pairing_params)
    if @pairing.save
      redirect_to :back
    else
      flash[:warn] = "There was and error, please try again"
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
      redirect_to :back
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
end