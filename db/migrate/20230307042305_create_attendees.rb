class CreateAttendees < ActiveRecord::Migration[6.1]
  def change
    create_table :attendees do |t|
      t.integer :event_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
