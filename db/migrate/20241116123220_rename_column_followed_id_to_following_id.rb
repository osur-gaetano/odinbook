class RenameColumnFollowedIdToFollowingId < ActiveRecord::Migration[7.2]
  def change
    rename_column(:follow_requests, :followed_id, :following_id)
  end
end
