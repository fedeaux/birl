class Session < ApplicationRecord
  belongs_to :training
  has_many :session_progressions, dependent: :destroy
  has_many :progressions, ->{ order(:order) }, through: :session_progressions

  def human_weekday
    ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][weekday]
  end

  def done_today
    progressions.all?(&:done_today)
  end

  def started_today
    progressions.any?(&:done_today)
  end
end
