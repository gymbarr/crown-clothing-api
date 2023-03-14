# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :order, inverse_of: :line_items
  belongs_to :variant, inverse_of: :line_items

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  delegate :title, :color, :size, :image, to: :variant
end
