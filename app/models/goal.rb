class Goal < ApplicationRecord
  belongs_to :user
  has_many :goal_entries

  def ensure_entry(options)
    start = user.in_time_zone(options[:base_date]).beginning_of_day
    finish = user.in_time_zone(options[:base_date]).end_of_day
    goal_entries.ensure(start, finish)
  end
end
