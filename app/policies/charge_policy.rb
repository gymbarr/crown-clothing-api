# frozen_string_literal: true

class ChargePolicy < ApplicationPolicy
  def create?
    logged_in?
  end
end
