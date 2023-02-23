# frozen_string_literal: true

class User < ApplicationRecord
  VALID_USERNAME_REGEX = /\A[a-z][a-z0-9_-]*\z/i
  rolify

  after_create :assign_default_role

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true, format: { with: VALID_USERNAME_REGEX }
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  validates :roles, presence: true, on: :update

  def assign_default_role
    add_role(Role.basic_user_role) if roles.blank?
  end
end
