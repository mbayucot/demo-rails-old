class User < ApplicationRecord
  enum role: { author: 0, editor: 1, administrator: 2 }

  has_many :posts
  has_many :subscriptions

  after_initialize :set_default_role, :if => :new_record?
  after_create :set_stripe_customer_id

  def set_default_role
    self.role ||= :author
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
         #:omniauthable, :confirmable, :lockable, :timeoutable, :trackable,

  def set_stripe_customer_id
    CreateStripeCustomerJob.perform_later(self.id)
  end

  def name
    "#{first_name} #{last_name}"
  end
end
