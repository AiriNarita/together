class AddGmapToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :address, :string, null: true
    add_column :events, :latitude, :string, null: true
    add_column :events, :longitude, :string, null: true
    add_column :events, :event_type, :integer, default: 0, null: false
  end
end
