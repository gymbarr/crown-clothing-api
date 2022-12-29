class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :title, default: '', null: false
      t.index :title, unique: true

      t.timestamps
    end
  end
end
