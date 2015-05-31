class Pairing < ActiveRecord::Base
  belongs_to :user
  belongs_to :pair, class_name: 'User'

  validates :user_id, :pair_id, presence: true
end
