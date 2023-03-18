class CreateRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :relations do |t|
      t.integer :followed_id, class_name: "User", null: false
      t.integer :follower_id, class_name: "User", null: false
      t.timestamps
    end
  end
end
