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

  def current_sessions
    current_training.sessions
  end

  def todays_weekday_in_timezone
    DateTime.now.in_time_zone(user.timezone).wday
  end

  def sessions_on_this_weekday
    current_training.sessions.where(weekday: todays_weekday_in_timezone)
  end

  def current_session
    return current_training.sessions.first unless name == 'bodybuilding'

    being_performed_now_session = sessions_on_this_weekday.where('updated_at >= ?', 12.hours.ago).first
    return being_performed_now_session if being_performed_now_session

    sessions_on_this_weekday.order(:updated_at).first
  end

  def todays_things
    todays_things = { context: self }

    if slug == 'music'
      todays_things[:progressions] = progressions.all
    elsif slug == 'bodybuilding'
      todays_things[:sessions] = current_sessions.first(3)
    end

    todays_things
  end

  def dynamic_css
    ".current-context-#{slug} .context-dependent-background-color, .current-context-#{slug} .ui.primary.button { background-color: #{color} !important }"
  end
end
