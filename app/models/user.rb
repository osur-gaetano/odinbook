class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, inverse_of: "author"
  has_many :likes, inverse_of: :user
  has_many :comments, inverse_of: :user

  has_many :sent_follow_requests, -> { where(status: "pending") }, foreign_key: "follower_id", class_name: "FollowRequest"
  has_many :received_follow_requests, -> { where(status: "pending") }, foreign_key: "following_id", class_name: "FollowRequest"

  has_many :approved_sent_follow_requests, -> { where(status: "approved") }, foreign_key: "follower_id", class_name: "FollowRequest"
  has_many :approved_received_follow_requests, -> { where(status: "appoved") }, foreign_key: "following_id", class_name: "FollowRequest"


  # approved
  has_many :followings, through: :approved_sent_follow_requests
  has_many :followers, through: :approved_received_follow_requests

  # pending
  has_many :pending_followings, through: :sent_follow_requests, source: :following
  has_many :pending_followers, through: :received_follow_requests, source: :follower

  validates :username, presence: true


  def send_follow_request(following)
    self.sent_follow_requests.build(following: following)
    self.save
  end

  def follow_request_not_sent
    User.where.not(id: sent_follow_requests.select(:following_id)).where.not(id: approved_sent_follow_requests.select(:following_id))
  end
end
