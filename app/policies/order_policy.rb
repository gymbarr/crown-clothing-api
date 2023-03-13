# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  class UserOrdersScope < ApplicationPolicy::Scope
    def resolve
      scope.where(user:)
    end
  end

  def create?
    true
  end

  def index?
    # admin? || same_user?
    true
  end

  def show?
    # admin? || same_user?
    true
  end

  # private

  # def same_user?
  #   @user&.id == @record&.id
  # end
end
