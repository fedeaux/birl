class Day < ApplicationRecord
  has_many :timelogs
  belongs_to :user

  def self.ensure(user, date: user.time_now)
    user.days.where(stamp: Day.stamp(date)).first_or_create
  end

  def self.stamp(date = DateTime.now)
    date.strftime('%Y-%m-%d')
  end
end
