class PostHashtag < ApplicationRecord
  belongs_to: hashtag
  belongs_to: post
end
