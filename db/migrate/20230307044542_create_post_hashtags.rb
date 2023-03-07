class CreatePostHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_hashtags do |t|
      t.integer :hashtag_id, null: false
      t.integer :post_id, null: false
      t.timestamps
    end
  end
end
