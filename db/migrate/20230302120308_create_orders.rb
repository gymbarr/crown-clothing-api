# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :total, default: 0, null: false
      t.string :status, default: '', null: false

      t.timestamps
    end
  end
end
