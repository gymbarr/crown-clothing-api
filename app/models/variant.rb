class Variant < ApplicationRecord
  belongs_to :product

  validates :size, uniqueness: { scope: [:color, :product_id] }

  delegate :title, :price, :image, to: :product
end
