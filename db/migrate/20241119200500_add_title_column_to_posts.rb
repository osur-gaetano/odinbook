class AddTitleColumnToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column(:posts, :title, :text, null: false)
  end
end
