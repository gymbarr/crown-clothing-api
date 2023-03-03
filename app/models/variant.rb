# frozen_string_literal: true

class Variant < ApplicationRecord
  belongs_to :product
  has_many :line_items, dependent: :destroy
  has_many :orders, -> { distinct }, through: :line_items

  validates :color, :size, presence: true
  validates :size, uniqueness: { scope: %i[color product_id] }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  delegate :title, :price, :image, :category_id, to: :product
end
