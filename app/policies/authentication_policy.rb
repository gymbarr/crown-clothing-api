# frozen_string_literal: true

class AuthenticationPolicy < ApplicationPolicy
  def login?
    true
  end
end
