class CreateReporteds < ActiveRecord::Migration[6.1]
  def change
    create_table :reporteds do |t|
      t.integer :user_id
      t.integer :reporter_id
      t.text :content
      t.boolean :checked, default: false
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
