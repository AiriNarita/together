class CreateHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :hashtags do |t|
      t.string :hashtag_name, null: false
      t.timestamps
    end
  end
end
