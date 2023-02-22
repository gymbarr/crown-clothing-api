class ChargePolicy < ApplicationPolicy
  def create?
    logged_in?
  end
end
