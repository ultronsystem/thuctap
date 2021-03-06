class CreateUserBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_books do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.boolean :is_favorite, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
