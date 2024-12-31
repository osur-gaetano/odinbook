class FollowRequest < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"

  def accept_follow_request
    self.status = "accepted"
    self.save
  end
end
