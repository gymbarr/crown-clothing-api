class UserPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    admin? || same_user?
  end

  def destroy?
    admin? || same_user?
  end

  def index?
    admin?
  end

  def show?
    admin? || same_user?
  end

  private

  def same_user?
    @user.id == @record.id
  end
end
