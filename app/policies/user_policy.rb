class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      user.author? ? scope.where(id: user.id) : scope.all
    end
  end
end
