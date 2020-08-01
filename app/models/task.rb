class Task < ApplicationRecord
  belongs_to :user

  # 今日のタスクを取得
  def get_today_tasks; end
  
  # 今週のタスク取得
  def get_this_week_tasks; end
end
