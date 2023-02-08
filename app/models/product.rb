class Product < ApplicationRecord
  include PgSearch::Model

  TITLE_MIN_LENGTH = 3
  TITLE_MAX_LENGTH = 40

  belongs_to :category
  has_many :variants, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true, length: { minimum: TITLE_MIN_LENGTH, maximum: TITLE_MAX_LENGTH }

  multisearchable against: %i[title]
end
