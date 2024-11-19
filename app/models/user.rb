class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments

  has_many :sent_follow_requests, foreign_key: "following_id", class_name: "FollowRequest"
  has_many :received_follow_requests, foreign_key: "follower_id", class_name: "FollowRequest"

  has_many :followers, through: :sent_follow_requests
  has_many :followings, through: :received_follow_requests

  validates :username, presence: true
end
