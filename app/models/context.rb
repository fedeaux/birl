class Context < ApplicationRecord
  belongs_to :user

  has_many :groups, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_many :challenges, dependent: :destroy
  has_many :progressions, dependent: :destroy
  has_many :trainings, dependent: :destroy

  def current_training
    trainings.last
  end

  def todays_weekday_in_timezone
    DateTime.now.in_time_zone(user.timezone).wday
  end

  def sessions_on_this_weekday
    current_training.sessions.where(weekday: todays_weekday_in_timezone)
  end

  def current_session
    being_performed_now_session = sessions_on_this_weekday.where('updated_at >= ?', 12.hours.ago).first
    return being_performed_now_session if being_performed_now_session

    sessions_on_this_weekday.order(:updated_at).first
  end
end
