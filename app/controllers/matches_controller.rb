class MatchesController < ApplicationController
 before_action :require_current_user

  def update
    @match = Match.find_by(id: params[:id])
    if @match.update_attributes(match_params)
      redirect_to :back
    else
      flash[:warn] = "Couldn't add second matchmaker"
      redirect_to :back
    end
  end

  private

  def match_params
    params.require(:match).permit(:user_id, :matcher_id)
  end

end
