class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat

  validates :user_id, :content, presence: true
end