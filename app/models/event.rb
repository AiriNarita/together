class Event < ApplicationRecord
  has_many :attendees
  has_many :users, through: :attendees
  belongs_to :creator, class_name: "User"

  #ActiveStorageの設定
  has_one_attached :event_image

  #creatorを参加者に含めない
  def attendees_for(user)
    if user.present?
      # 参加者リストから自分と投稿者を除いた参加者リストを返す
      return attendees.where.not(user: [user, creator])
    else
      return attendees
    end
  end

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
  #利用停止のUserの投稿は閲覧不可に
  scope :by_active_users, -> { joins(:creator).select("events.*, creator.user_status").where(creator: { user_status: 0 }).distinct }
  scope :upcoming, -> { where("date >= ?", Time.zone.now).order(date: :asc) }
  scope :visible, -> { by_active_users.upcoming }
end
