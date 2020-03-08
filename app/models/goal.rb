class Goal < ApplicationRecord
  belongs_to :user
  has_many :goal_entries

  def ensure_entry(options)
    start = options[:base_date].beginning_of_day
    finish = options[:base_date].end_of_day

    goal_entries.ensure(start, finish)
  end

  def entry_meta
    meta[:entry_meta] || {}
  end
end
