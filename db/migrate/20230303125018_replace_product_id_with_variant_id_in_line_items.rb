# frozen_string_literal: true

class ReplaceProductIdWithVariantIdInLineItems < ActiveRecord::Migration[7.0]
  def change
    remove_reference :line_items, :product, foreign_key: true, index: true
    add_reference :line_items, :variant, foreign_key: true, index: true
  end
end
