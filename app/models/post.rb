class Post < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :user, dependent: :destroy
  has_many :post_hashtag, dependent: :destroy

  #下書き、公開のenum設定
  enum post_status: { published: 0, draft: 1 }
end
