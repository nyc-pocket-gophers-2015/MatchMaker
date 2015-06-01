class RejectedPairingsController < ApplicationController
  def create
    @rejected_pairing = RejectedPairing.new(user_id: current_user.id, pairing_id: params[:pairing_id])
    if @rejected_pairing.save
      redirect_to new_pairing_path(user_id: current_user.id)
    else
      flash[:warn] = "Unable to save your input, please try again"
      redirect_to new_pairing_path(user_id: current_user.id)
    end
  end
end