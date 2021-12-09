class Subscription < ApplicationRecord
  enum status: { trial: 1, active: 2, cancelled: 3 }

  belongs_to :user

  validates :stripe_subscription_id, presence: true
end
