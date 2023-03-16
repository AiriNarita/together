class Post < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  belongs_to :user
  #hashtag機能
  has_many :post_hashtags, dependent: :destroy
  has_many :hashtags, through: :post_hashtags

  #下書き、公開のenum設定
  enum post_status: { published: 0, draft: 1 }

  #下書き機能
  def save_draft
    self.post_status = :draft
    save(validate: false)
  end

  #利用停止のuserの投稿を閲覧不可に。
  scope :published, -> { where(post_status: :published) }
  scope :by_active_users, -> { joins(:user).where(users: { user_status: 0 }) }
  scope :visible, -> { published.by_active_users }

  #いいね機能
  def favorited_by?(user)
    #favorites.exists?(user_id: user.id)
    user.present? && favorites.exists?(user_id: user.id)
  end

  #検索用
  def self.search_content(content, method)
    if method == "perfect"
      where(title: content)
    elsif method == "partial"
      where("title LIKE ?", "%#{content}%")
    else
      all
    end
  end
end
