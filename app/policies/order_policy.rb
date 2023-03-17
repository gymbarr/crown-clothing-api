# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  class UserOrdersScope < ApplicationPolicy::Scope
    def resolve
      scope.where(user:)
    end
  end

  def create?
    logged_in?
  end

  def index?
    logged_in?
  end

  def show?
    logged_in? && same_user?
  end

  private

  def same_user?
    @user&.id == @record.user.id
  end
end
