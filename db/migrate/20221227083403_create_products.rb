# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title, default: '', null: false
      t.string :image_url, default: '', null: false
      t.integer :price, default: 0, null: false
      t.references :category, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
