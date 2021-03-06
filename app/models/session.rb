class Session < ApplicationRecord
  belongs_to :training
  has_many :session_progressions, dependent: :destroy
  has_many :progressions, -> { order(:order) }, through: :session_progressions

  def human_weekday
    %w[Sun Mon Tue Wed Thu Fri Sat][weekday]
  end

  def done_today
    executed_at && executed_at > 12.hours.ago
  end

  def done_today?
    executed_at && executed_at > 12.hours.ago
  end

  def started_today
    progressions.any?(&:done_today)
  end

  def last_entry_at
    progressions.maximum :last_entry_at
  end
end
