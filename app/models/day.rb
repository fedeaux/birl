class Day < ApplicationRecord
  belongs_to :day, optional: true
  belongs_to :user

  def self.ensure(user)
    user.days.where(stamp: Day.stamp(user.time_now)).first_or_create
  end

  def self.stamp(date = DateTime.now)
    date.strftime('%Y-%m-%d')
  end
end
