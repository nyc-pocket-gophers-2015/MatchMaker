class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :pair

  validates :user_id, :pairing_id, :score, presence: true
end