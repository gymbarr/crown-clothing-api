# frozen_string_literal: true

class CreateProductVariants < ActiveRecord::Migration[7.0]
  def change
    create_table :product_variants do |t|
      t.string :color, default: '', null: false
      t.string :size, default: '', null: false
      t.references :product, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
