# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: {
    unpaid: 0,
    paid: 1,
    prepaid: 2
  }

  belongs_to :user
  has_many :line_items, dependent: :destroy

  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true
  validates_with EnoughVariantsValidator, if: :unpaid_or_prepaid

  before_validation :set_total!

  def build_line_items(requested_items)
    requested_items.each do |requested_item|
      variant_id = requested_item[:variant_id]
      quantity = requested_item[:quantity]

      line_items.build(variant_id:, quantity:)
    end
  end

  def set_total!
    self.total = line_items.inject(0) { |total, item| total + (item.price * item.quantity) }
  end

  def unpaid_or_prepaid
    unpaid? || prepaid?
  end
end
