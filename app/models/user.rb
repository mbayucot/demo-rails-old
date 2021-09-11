class User < ApplicationRecord
  enum role: [:customer, :staff, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :customer
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :omniauthable, :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
end
