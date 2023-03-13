class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #いいね、投稿、コメント機能のassociation
  has_many :favorites, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  #イベント関連のassociation
  has_many :attendees
  has_many :events, through: :attendees

  #full_nameメソッド
  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  #検索用
  def self.search_content(content, method)
    if method == "perfect"
      where("first_name = ? OR last_name = ?", content, content)
    elsif method == "partial"
      where("first_name LIKE ? OR last_name LIKE ?", "%#{content}%", "%#{content}%")
    else
      all
    end
  end

  #ActiveStorageの設定
  has_one_attached :image
end
