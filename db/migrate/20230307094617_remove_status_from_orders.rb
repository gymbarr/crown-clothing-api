# frozen_string_literal: true

class RemoveStatusFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :status, :string, default: '', null: false
  end
end
