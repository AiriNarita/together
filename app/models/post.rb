class Post < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  belongs_to :user
  has_many :post_hashtag, dependent: :destroy

  #下書き、公開のenum設定
  enum post_status: { published: 0, draft: 1 }

  #下書き機能
  def save_draft
    self.post_status = :draft
    save(validate: false)
  end
end
