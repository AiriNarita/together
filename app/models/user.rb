class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #いいね、投稿、コメント機能のassociation
  has_many :favorites, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  #通報
  has_many :reporter, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reported, class_name: "Report", foreign_key: "reported_id", dependent: :destroy

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

  #user_status
  enum user_status: { available: 0, suspended: 1 }, _default: 0

  # 自動利用停止メソッド1  通報回数のカウント
  def report_count
    Report.where(reported_id: id).count
  end

  # 自動利用停止メソッド2  3回以上通報されたかチェック
  def exceeded_report_limit?
    report_count >= 3
  end

  #ActiveStorageの設定
  has_one_attached :image

  #following function
  has_many :follower, class_name: "Relation", foreign_key: "follower_id", dependent: :destroy # フォローしている人の取得
  has_many :followed, class_name: "Relation", foreign_key: "followed_id", dependent: :destroy # フォローされているの人取得

  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end
end
