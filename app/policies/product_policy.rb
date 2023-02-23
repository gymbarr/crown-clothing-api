# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
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

  def show_variants?
    true
  end
end
