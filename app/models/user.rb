class User < ApplicationRecord
  enum role: { author: 1, editor: 2, admin: 3 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

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
   CreateStripeCustomerJob.perform_later(self.id) if self.author?
  end
end
