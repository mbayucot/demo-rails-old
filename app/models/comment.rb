class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user

  has_ancestry

  acts_as_votable
end
