class Listing < ApplicationRecord
  include AASM
  acts_as_taggable_on :tags

  enum state: {
    draft: 0,
    pending: 1,
    published: 2
  }

  enum condition: {
    new: 0,
    used: 1,
    refurbished: 2
  }

  belongs_to :category
  belongs_to :user

  has_many_attached :photos

  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :description, presence: true
  validates :condition, presence: true

  aasm column: :state, enum: true do
    state :draft, initial: true
    state :pending, :published

    event :submit do
      transitions from: :draft, to: :pending
    end

    event :approve do
      transitions from: :pending, to: :published
    end
  end
end
