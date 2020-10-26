class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, -> { where confirmed: true }
  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :friendship_requests, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    @friends = friendships.map(&:friend)
  end

  def pending_friends
    @pending_friends = pending_friendships.map(&:friend)
  end

  def friend_requests
    @friend_requests = friendship_requests.map(&:user)
  end

  def friend?(user)
    friends.include?(user)
  end
end
