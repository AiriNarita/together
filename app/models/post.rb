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

  #いいね機能
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # hashtag
  def save_tag(sent_tags)
    current_hashtags = self.hashtags.pluck(:hashtag_name) unless self.hashtags.nil?
    old_hashtags = current_hashtags - sent_tags
    new_hashtags = sent_tags - current_hashtags

    old_hashtags.each do |old|
      self.hashtags.delete Hashtag.find_by(hashtag_name: old)
    end

    new_hashtags.each do |new|
      new_post_hashtag = Hashtag.find_or_create_by(hashtag_name: new)
      self.hashtags << new_post_hashtag
    end
  end
end
