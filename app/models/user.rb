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

  has_many :rejected_pairings

  validates :name, :email, :password_digest, :birthday, :gender, :location, :preferred_gender, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create
  validate :validate_age

  def all_friends
    return (friends + inverse_friends)
  end

  def is_friends(user)
    all_approved_friends.find{ |friend| friend.id == user.id }
  end

  def friendship(user)
    u = all_friendships.find{ |friendship| friendship.user == user }
    f = all_friendships.find{ |friendship| friendship.friend == user }
    u || f
  end

  def all_approved_friends
    #REFACTOR!!!!!!!!!! But it works, so yeah
    approved_friends = []
    approved_friends.concat(all_approved_friendships.select{ |friendship| friendship.user == self}.map(&:friend))
    approved_friends.concat(all_approved_friendships.select{ |friendship| friendship.friend == self}.map(&:user))
    approved_friends
  end

  def all_friendships
    return (friendships + inverse_friendships)
  end

  def all_approved_friendships
    all_friendships.select { |friendship| friendship.status == "approved" }
  end

  def mailboxer_email(object)
  end

  def can_be_friends(user)
    return false if user == self
    return false if user.all_friends.include?(self)
    return true
  end

  def pending_friendships
    Friendship.where(friend_id: id, status: "pending")
  end

  def age
    age = Date.today.year - birthday.year
  end

  def validate_age
    age
    errors.add(:birthday, "Must be 18 years or older to register") if age < 18
  end

  def preferred_age_range
    (preferred_age_low..preferred_age_high)
  end

  def all_pairings
    return (pairings + inverse_pairings)
  end

  def all_pending_pairings
    all_pairings.select { |pairing| pairing.match.matcher == nil }
  end

  def find_random_pending_pair_from_friends
    all_friends.shuffle.each do |friend|
      pot_pairings = friend.all_pending_pairings
      pot_pairings.delete_if{ |pairing| pairing.match.user == self }
      pot_pairings.delete_if{ |pairing| pairing.user_is_in_pairing(self) }
      pot_pairings.delete_if{ |pairing| pairing.user_rejected_pair(self) }
      return pot_pairings.sample if pot_pairings.length > 0
    end
    return nil
  end
end