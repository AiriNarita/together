class Event < ApplicationRecord
  has_many :attendees
  has_many :users, through: :attendees
  belongs_to :creator, class_name: "User"
end
