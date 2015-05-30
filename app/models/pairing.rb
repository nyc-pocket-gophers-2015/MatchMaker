class Pairing < ActiveRecord::Base
  belongs_to :user
  belongs_to :pair, class_name: 'User'
end
