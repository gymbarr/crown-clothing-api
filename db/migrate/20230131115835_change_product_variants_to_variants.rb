# frozen_string_literal: true

class ChangeProductVariantsToVariants < ActiveRecord::Migration[7.0]
  def change
    rename_table :product_variants, :variants
  end
end
