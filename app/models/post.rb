class Post < ApplicationRecord
  include AASM
  include PgSearch::Model

  acts_as_votable

  belongs_to :user, class_name: 'User'

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  scope :ordered, -> { order(updated_at: :desc) }

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

  multisearchable against: %i[title body tags]
  pg_search_scope :search,
                  against: %i[title body],
                  associated_against: {
                    user: %i[first_name last_name], tags: %i[name]
                  },
                  using: { tsearch: { prefix: true } }
end
