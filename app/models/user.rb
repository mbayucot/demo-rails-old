class User < ApplicationRecord
  enum role: { author: 0, editor: 1, administrator: 2 }

  has_many :articles

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :author
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
         #:omniauthable, :confirmable, :lockable, :timeoutable, :trackable,
end
