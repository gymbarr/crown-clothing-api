# frozen_string_literal: true

class AddPriceToLineItems < ActiveRecord::Migration[7.0]
  def change
    add_column :line_items, :price, :integer, default: 0, null: false
  end
end
