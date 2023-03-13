class Event < ApplicationRecord
  has_many :attendees
  has_many :users, through: :attendees
  belongs_to :creator, class_name: "User"

  #検索用
  def self.search_content(content, method)
    if method == "perfect"
      where(event_name: content)
    elsif method == "partial"
      where("event_name LIKE ?", "%#{content}%")
    else
      all
    end
  end
end
