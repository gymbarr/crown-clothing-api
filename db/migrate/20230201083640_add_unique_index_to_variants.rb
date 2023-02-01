class AddUniqueIndexToVariants < ActiveRecord::Migration[7.0]
  def change
    add_index :variants, %i[size color product_id], unique: true
  end
end
