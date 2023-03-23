# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :order, inverse_of: :line_items
  belongs_to :variant, inverse_of: :line_items

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :enough_variant_quantity

  delegate :title, :color, :size, :image, to: :variant
  delegate :user, to: :order

  after_update :set_order_total!

  def set_order_total!
    order.set_total!
    order.save
  end

  def enough_variant_quantity
    return unless quantity > variant.quantity

    errors.add(:quantity, :invalid,
               message: "#{variant.title} is out of stock, just #{variant.quantity} left")
  end
end
