# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: {
    unpaid: 0,
    paid: 1,
    completed: 2
  }

  belongs_to :user
  has_many :line_items, dependent: :destroy

  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true
  validates_with EnoughVariantsValidator, if: -> { unpaid? }

  before_validation :set_line_items_prices!, :set_total!, if: -> { unpaid? || paid? }

  def build_line_items(requested_items)
    requested_items.each do |requested_item|
      variant_id = requested_item[:variant_id]
      quantity = requested_item[:quantity]

      line_items.build(variant_id:, quantity:)
    end
  end

  def set_line_items_prices!
    line_items.each do |line_item|
      line_item.price = line_item.variant.price
    end
  end

  def set_total!
    self.total = line_items.inject(0) { |total, line_item| total + (line_item.price * line_item.quantity) }
  end
end
