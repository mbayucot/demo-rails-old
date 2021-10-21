class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :body, presence: true

  has_ancestry
end
