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
  has_many :created_events, class_name: "Event", foreign_key: "creator_id"

  #event メソッド

  #ActiveStrageの設定
  has_one_attached :image
end
