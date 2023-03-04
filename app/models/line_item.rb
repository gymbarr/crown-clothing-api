# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :order, inverse_of: :line_items
  belongs_to :variant, inverse_of: :line_items

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  after_create :decrement_variant_quantity

  def decrement_variant_quantity
    variant.decrement(:quantity, quantity)
    variant.save
  end
end
