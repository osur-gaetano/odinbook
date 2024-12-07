class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, inverse_of: :comments

  validates :content, presence: true
end
