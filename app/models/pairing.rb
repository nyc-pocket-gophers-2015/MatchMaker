class Pairing < ActiveRecord::Base
  belongs_to :user
  belongs_to :pair, class_name: 'User'
  belongs_to :match
  has_many   :rejected_pairings

  validates :user_id, :pair_id, presence: true

  def user_rejected_pair(current_user)
    rejected_pairings.find_by(user_id: current_user.id) ? true : false
  end
end
