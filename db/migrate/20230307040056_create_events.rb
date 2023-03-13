class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :creator_id, null: false
      t.datetime :date, null: false
      t.string :event_name, null: false
      t.text :event_introduction, null: false
      t.text :url, null: false

      t.timestamps
    end
  end
end
