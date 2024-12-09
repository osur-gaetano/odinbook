class AddStatusToFollowRequests < ActiveRecord::Migration[7.2]
  def change
    add_column :follow_requests, :status, :string, default: "pending"
  end
end
