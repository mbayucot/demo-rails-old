class Subscription < ApplicationRecord
  belongs_to :user

  validates :stripe_subscription_id, presence: true
end
