# frozen_string_literal: true

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

  def me?
    true
  end

  private

  def same_user?
    @user&.id == @record&.id
  end
end
