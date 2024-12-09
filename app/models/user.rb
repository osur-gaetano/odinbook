class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, inverse_of: "author"
  has_many :likes, inverse_of: :user
  has_many :comments, inverse_of: :user

  has_many :sent_follow_requests, foreign_key: "follower_id", class_name: "FollowRequest"
  has_many :received_follow_requests, foreign_key: "following_id", class_name: "FollowRequest"

  has_many :followings, through: :sent_follow_requests
  has_many :followers, through: :received_follow_requests

  validates :username, presence: true
end
