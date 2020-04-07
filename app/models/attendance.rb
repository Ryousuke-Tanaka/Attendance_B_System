class Attendance < ApplicationRecord
  belongs_to :user
  
  validates :worked_on, presence: true
  validates :note, length: { maximum: 100 }
  
  # 出勤時間が存在しない場合、退勤時間は無効
  validate :finished_at_is_invalid_without_a_started_at
  # 今日以外の日付で退勤時間が存在しない場合、出勤時間は無効
  validate :started_at_is_invalid_without_a_finished_at
  # 出勤・退勤時間どちらも存在する場合、出勤時間よりも退勤時間が早い場合は無効
  validate :started_at_than_finished_at_fast_if_invalid
  
  def finished_at_is_invalid_without_a_started_at
    errors.add(:started_at, "が必要です") if started_at.blank? && finished_at.present?
  end
  
  def started_at_is_invalid_without_a_finished_at
    if worked_on < Date.current
      unless (started_at.present? && finished_at.present?) || (started_at.blank? && finished_at.blank?)
        errors.add(:finished_at, "が必要です")
      end
    end
  end
  
  def started_at_than_finished_at_fast_if_invalid
    if started_at.present? && finished_at.present?
      errors.add(:started_at, "より早い退勤時間は無効です。") if started_at > finished_at
    end
  end
end
