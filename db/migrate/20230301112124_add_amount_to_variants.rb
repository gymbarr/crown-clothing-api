# frozen_string_literal: true

class AddAmountToVariants < ActiveRecord::Migration[7.0]
  def change
    add_column :variants, :amount, :integer, default: 0, null: false
  end
end
