# frozen_string_literal: true

class LineItemPolicy < ApplicationPolicy
  def increment_quantity?
    logged_in? && same_user?
  end

  def decrement_quantity?
    logged_in? && same_user?
  end

  def destroy?
    logged_in? && same_user?
  end

  private

  def same_user?
    @user&.id == @record.user.id
  end
end
