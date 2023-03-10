class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :user_id, null: false
      t.integer :creator_id, null: false
      t.datetime :date, null: false
      t.string :event_name, null: false
      t.text :event_introduction, null: false
      t.string :creater, null: false
      t.integer :Sharing_status, default: 0
      t.text :url, null: false

      t.timestamps
    end
  end
end
