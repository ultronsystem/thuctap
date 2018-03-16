class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.references :user, foreign_key: true
      t.integer :type_id
      t.string :type_activity
      t.string :content_action

      t.timestamps
    end
  end
end
