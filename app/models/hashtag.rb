class Hashtag < ApplicationRecord
  validates :hashtag_name, presence: true, length: { maximum: 50 }
  has_many :post_hashtags
  has_many :posts, through: :post_hashtags

  #検索用
  def self.search_content(content, method)
    if method == "perfect"
      where(hashtag_name: content).includes(:posts)
    elsif method == "partial"
      where("hashtag_name LIKE ?", "%#{content}%").includes(:posts)
    else
      all.includes(:posts)
    end
  end
end
