class Pairing < ActiveRecord::Base
  belongs_to :user
  belongs_to :pair, class_name: 'User'
  belongs_to :match
  has_many   :votes
  has_many   :rejected_pairings

  validates :user_id, :pair_id, presence: true

  def user_rejected_pair(current_user)
    votes.find_by(user_id: current_user.id) ? true : false
  end

  def is_finished
    return true if votes.count >= 10
    return true if is_approved
    return true if votes.where(score: -1).count >= 5
    false
  end

  def is_approved
    total = votes.count
    approved_votes_total = votes.where(score: 1).count
    return false if votes.count < 3
    return true if approved_votes_total >= (3 + 0.5 * (total - 3)).floor
    false
  end

  def voted_by_user(user)
    votes.each { |vote| return true if vote.user == user }
    return false
  end

  def user_is_in_pairing(current_user)
    return true if user == current_user
    return true if pair == current_user
    false
  end
end
