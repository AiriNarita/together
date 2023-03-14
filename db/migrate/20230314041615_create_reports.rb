class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :reporter_id
      t.integer :reported_id
      t.text :content, null: false
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
