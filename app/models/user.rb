class User < ActiveRecord::Base
  acts_as_messageable
  has_secure_password
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :pairings
  has_many :pairs, through: :pairings
  has_many :inverse_pairings, class_name: "Pairing", foreign_key: "pair_id"
  has_many :inverse_pairs, through: :inverse_pairings, source: :user

  has_many :matches
  has_many :matchers, through: :matches
  has_many :inverse_matches, class_name: "Match", foreign_key: "match_id"
  has_many :inverse_matchers, through: :inverse_matches, source: :user

  validates :name, :email, :password_digest, :birthday, :gender, :location, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create
  validate :validate_age

  def all_friends
    return (friends + inverse_friends)
  end

  def mailboxer_email(object)
  end

  def can_be_friends(user)
    return false if user == self
    return false if user.all_friends.include?(self)
    return true
  end

  def pending_friendships
    Friendship.where(friend_id: id, status: false)
  end

  def validate_age
    age = Date.today.year - birthday.year
    errors.add(:birthday, "Must be 18 years or older to register") if age < 18
  end
end