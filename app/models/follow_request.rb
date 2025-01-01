class FollowRequest < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"

  validates :follower_id, uniqueness: { scope: :following_id, message: "You have already sent a follow request to this user" }

  def approve_follow_request
    self.status = "approved"
    self.save
  end
end
