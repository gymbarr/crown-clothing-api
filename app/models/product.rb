class Product < ApplicationRecord
  TITLE_MIN_LENGTH = 3
  TITLE_MAX_LENGTH = 40

  belongs_to :category
  has_many :product_variants, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true, length: { minimum: TITLE_MIN_LENGTH, maximum: TITLE_MAX_LENGTH }
  validates :category, presence: true

  def colors
    product_variants.select(:color)
                    .group(:color)
                    .pluck(:color)
  end

  def sizes(color = product_variants.first.color)
    product_variants.select(:size)
                    .group(:size)
                    .where(color:)
                    .pluck(:size)
                    .sort
  end
end
