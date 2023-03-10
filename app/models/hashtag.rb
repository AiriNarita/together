class Hashtag < ApplicationRecord
  validates :hashtag_name, presence: true, length: { maximum: 50 }
  has_many :post_hashtags
  has_many :posts, through: :post_hashtags
end
