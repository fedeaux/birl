class Day < ApplicationRecord
  has_many :timelogs
  belongs_to :user
  belongs_to :week
  before_validation :ensure_name
  before_validation :ensure_week
  default_scope -> { order :stamp }

  def self.ensure(user, date: user.time_now)
    user.days.where(stamp: Day.stamp(user.in_time_zone(date))).first_or_create
  end

  def self.stamp(date = DateTime.now)
    date.strftime('%Y-%m-%d')
  end

  def to_date_time
    DateTime.parse stamp
  end

  def start
    to_date_time.beginning_of_day
  end

  def finish
    to_date_time.end_of_day
  end

  def ensure_name
    self.name = to_date_time.strftime '%a, %b %d, %Y'
  end

  def ensure_week
    self.week = Week.ensure(user, date: to_date_time)
  end
end
