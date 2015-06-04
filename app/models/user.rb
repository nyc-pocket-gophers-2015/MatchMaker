class User < ActiveRecord::Base
  has_secure_password
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :pairings
  has_many :pairs, through: :pairings
  has_many :inverse_pairings, class_name: "Pairing", foreign_key: "pair_id"
  has_many :inverse_pairs, through: :inverse_pairings, source: :user

  has_many :chats
  has_many :chatters, through: :chats
  has_many :inverse_chats, class_name: "Chat", foreign_key: "chatter_id"
  has_many :inverse_chatters, through: :inverse_chats, source: :user

  has_many :notifications
  has_many :votes
  has_many :messages

  validates :name, :email, :password_digest, :gender, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create

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

  def can_be_friends(user)
    return false if user == self
    return false if user.all_friends.include?(self)
    return true
  end

  def pending_friendships
    Friendship.where(friend_id: id, status: "pending")
  end

  def all_chats
    return (chats + inverse_chats)
  end

  def other_chat_user(chat)
    chat.user.id == self.id ? chat.chatter : chat.user
  end

  def age
    age = Date.today.year - birthday.year
    age -= 1 if Date.today < birthday + age.years
  end

  def validate_age
    age
    errors.add(:birthday, "Must be 18 years or older to register") if age < 18
  end

  def get_recent_notifications(num)
    notifications.order(created_at: :desc).limit(num)
  end

  def mark_notifications_as_seen
    notifications.update_all(seen: true)
  end

  def preferred_age_range
    (preferred_age_low..preferred_age_high)
  end

  def all_pairings
    return (pairings + inverse_pairings)
  end

  def all_pending_pairings
    all_pairings.select { |pairing| pairing.is_finished == false }
  end

  def find_gravatar_url
    hash = Digest::MD5.hexdigest(email)
    return "http://www.gravatar.com/avatar/#{hash}"
  end

  def find_random_pending_pair_from_friends
    all_friends.shuffle.each do |friend|
      pot_pairings = friend.all_pending_pairings
      pot_pairings.delete_if{ |pairing| pairing.voted_by_user(self) }
      pot_pairings.delete_if{ |pairing| pairing.user_is_in_pairing(self) }
      return pot_pairings.sample if pot_pairings.length > 0
    end
    return nil
  end

  def self.from_omniauth(auth)
    user = find_by(provider: auth["provider"], uid: auth["uid"])
    if !user
      user = User.new
      user.provider = auth["provider"]
      user.uid = auth["uid"]
    end
    user.name = auth.info.name
    user.email = auth.info.email
    user.picture_url = auth.info.image
    user.gender = auth.extra.raw_info.gender
    user.location = auth.extra.raw_info.locale
    user.picture_url = auth.info.image
    user.password = "123"
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.save!
    user
  end

  def find_random_pair_from_friends
    all_approved_friends.shuffle.each do |friend|
      User.all.shuffle.each do |pot_pair|
        if friend.can_be_pair(pot_pair) && pot_pair != self
          return { friend: friend, pair: pot_pair }
        end
      end
    end
    nil
  end

  def can_be_pair(user)
    return false if user == self
    return false unless self.preferred_gender == user.gender || self.preferred_gender == "All"
    return false unless user.preferred_gender == self.gender || user.preferred_gender == "All"
    return false unless self.preferred_age_range.include?(user.age)
    return false if Pairing.find_by(user_id: self.id, pair_id: user.id)
    return false if Pairing.find_by(user_id: user.id, pair_id: self.id)
    true
  end
end