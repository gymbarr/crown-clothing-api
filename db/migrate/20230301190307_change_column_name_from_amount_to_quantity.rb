# frozen_string_literal: true

class ChangeColumnNameFromAmountToQuantity < ActiveRecord::Migration[7.0]
  def change
    rename_column :variants, :amount, :quantity
  end
end
