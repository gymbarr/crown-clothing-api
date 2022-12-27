class Category < ApplicationRecord
  TITLE_MIN_LENGTH = 3
  TITLE_MAX_LENGTH = 40

  has_many :products, dependent: :destroy

  validates :title, presence: true, uniqueness: true, length: { minimum: NAME_MIN_LENGTH, maximum: NAME_MAX_LENGTH }
end
