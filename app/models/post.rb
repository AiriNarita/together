class Post < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :user, dependent: :destroy
  has_many :post_hashtag, dependent: :destroy
end
