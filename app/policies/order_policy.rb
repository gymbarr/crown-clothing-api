# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  def create?
    true
  end

  def index?
    admin? || same_user?
  end

  def show?
    admin? || same_user?
  end

  private

  def same_user?
    @user&.id == @record&.id
  end
end
