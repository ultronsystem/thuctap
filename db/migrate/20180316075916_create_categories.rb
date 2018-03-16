class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name_cat

      t.timestamps
    end
    add_index :categories, :name_cat, unique: true
  end
end
