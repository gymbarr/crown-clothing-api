class Product < ApplicationRecord
  include PgSearch

  TITLE_MIN_LENGTH = 3
  TITLE_MAX_LENGTH = 40

  belongs_to :category
  has_many :variants, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true, length: { minimum: TITLE_MIN_LENGTH, maximum: TITLE_MAX_LENGTH }

  pg_search_scope :search_by_title, against: %i[title], using: { tsearch: { prefix: true } }
end
