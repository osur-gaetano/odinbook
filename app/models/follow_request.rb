class FollowRequest < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"

  def approve_follow_request
    self.status = "approved"
    self.save
  end
end
