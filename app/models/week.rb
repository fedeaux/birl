class Week < ApplicationRecord
  belongs_to :user
  before_save :ensure_name
  has_many :days
  default_scope -> { order :stamp }

  def self.ensure(user, date: user.time_now)
    user.weeks.where(stamp: Week.stamp(user.in_time_zone(date))).first_or_create
  end

  def self.stamp(date = DateTime.now)
    last_sunday = date - date.wday.days
    next_saturday = last_sunday + 6.days

    [last_sunday.strftime('%Y-%m-%d'), '->', next_saturday.strftime('%Y-%m-%d')].join
  end

  def to_date_times
    datetimes = stamp.split('->').map { |datetime| DateTime.parse datetime }
    [datetimes.first.beginning_of_day, datetimes.second.end_of_day]
  end

  def start
    to_date_times.first
  end

  def finish
    to_date_times.second
  end

  def ensure_name
    datetimes = to_date_times
    self.name = [datetimes.first.strftime('%b %d'), datetimes.second.strftime('%b %d (%Y)')].join ' to '
  end
end
