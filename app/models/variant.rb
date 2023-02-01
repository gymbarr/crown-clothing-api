class Variant < ApplicationRecord
  belongs_to :product

  delegate :title, :price, :image, to: :product
end
