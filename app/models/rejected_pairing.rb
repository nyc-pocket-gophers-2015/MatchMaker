class RejectedPairing < ActiveRecord::Base
  belongs_to :pairing
  belongs_to :user

  validates :pairing_id, :user_id, presence: true
end