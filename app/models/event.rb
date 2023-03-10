class Event < ApplicationRecord
  has_many :attendees
  has_many :users, through: :attendees
  belongs_to :creator, class_name: "User"

  #公開範囲enum設定
  enum sharing_status: { all_users: 0, liked_users: 1 }

  #creator_id をイベントが作成される前に作成者を自動的に設定するためのコールバック
  before_create :set_creator

  private

  # creatorは作ったログインしているuser
  def set_creator
    self.creator = User.current # User.current は、現在ログインしているユーザーを返すメソッド
  end
end
