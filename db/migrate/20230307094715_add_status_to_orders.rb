# frozen_string_literal: true

class AddStatusToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :status, :integer, default: 0, null: false
  end
end
