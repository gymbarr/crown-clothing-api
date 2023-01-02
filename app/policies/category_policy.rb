class CategoryPolicy < ApplicationPolicy
  def create?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  def index?
    true
  end

  def show?
    true
  end
end
