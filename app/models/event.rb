class Event < ApplicationRecord
  has_many :attendees
  has_many :users, through: :attendees
  belongs_to :creator, class_name: "User"

  #公開範囲enum設定
  enum sharing_status: { all_users: 0, liked_users: 1 }
end
