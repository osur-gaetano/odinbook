class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "user_id", inverse_of: :posts
  has_many :comments, dependent: :destroy, inverse_of: :post
  has_many :likes, inverse_of: :post

  validates :content, :title, presence: true

  def count_likes
    self.likes.count
  end

  def add_like(user_id)
    self.likes.build(user_id: user_id)
    self.save
  end
end
