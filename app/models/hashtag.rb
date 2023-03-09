class Hashtag < ApplicationRecord
  validates :hashname, presence: true, length: { maximum: 50 }
  has_many :post_hashtag
  has_many :posts, through: :hashtag_post_images
end
