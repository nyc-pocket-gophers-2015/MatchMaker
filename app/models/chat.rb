class Chat < ActiveRecord::Base
  belongs_to :user
  belongs_to :chatter, class_name: 'User'
  has_many   :messages

  validates :user_id, :chatter_id, presence: true
end