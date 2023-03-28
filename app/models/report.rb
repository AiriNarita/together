class Report < ApplicationRecord
  belongs_to :reporter, class_name: "User"
  belongs_to :reported, class_name: "User"

  # reporter_idがuser_idである通報の件数を返すクラスメソッド
  def self.reported_count(user_id)
    where(reported_id: user_id).count
  end

  # report.rb

  after_create :update_user_status

  def update_user_status
    reported_user = User.find(reported_id)
    if reported_user.report_count >= 3
      reported_user.update(user_status: :suspended)
    end
  end
end
