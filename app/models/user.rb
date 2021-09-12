class User < ApplicationRecord
  enum role: { customer: 0, staff: 1, admin: 2 }

  has_many :listings

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :customer
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
         #:omniauthable, :confirmable, :lockable, :timeoutable, :trackable,
end
