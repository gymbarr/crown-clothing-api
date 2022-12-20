class User < ApplicationRecord
  VALID_USERNAME_REGEX = /\A[a-z][a-z0-9_-]*\z/i

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true, format: { with: VALID_USERNAME_REGEX }
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
end
