class Variant < ApplicationRecord
  belongs_to :product

  delegate :price, to: :product
end
