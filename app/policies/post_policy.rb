class PostPolicy < ApplicationPolicy
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
    user.editor? ? record.user == user : true
  end

  def destroy?
    user.editor? ? record.user == user : true
  end

  class Scope < Scope
    def resolve
      user.author? ? scope.where(user_id: user.id) : scope.all
    end
  end
end
