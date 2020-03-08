class GoalEntry < ApplicationRecord
  belongs_to :goal

  delegate :name, to: :goal

  def self.ensure(start, finish)
    where(created_at: (start..finish)).first_or_create.tap do |goal_entry|
      goal_entry.ensure_default_values
      goal_entry.save
    end
  end

  def ensure_default_values
    self.meta ||= {}
    meta.reverse_merge! goal.goal_entry_default_meta
  end
end
