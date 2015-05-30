class Match < ActiveRecord::Base
  belongs_to :user
  belongs_to :matcher, class_name: 'User'
end
