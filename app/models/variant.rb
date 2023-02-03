class Variant < ApplicationRecord
  belongs_to :product

  validates :size, uniqueness: { scope: %i[color product_id] }

  delegate :title, :price, :image, :category_id, to: :product
end
