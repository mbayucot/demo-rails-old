class Article < ApplicationRecord
  include AASM

  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  acts_as_taggable_on :tags

  extend FriendlyId
  friendly_id :title, use: :slugged

  aasm do
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: :draft, to: :published
    end
  end
end
