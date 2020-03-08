class TimelogGoal < Goal
  def goal_entry_default_meta
    entry_meta.merge(duration_as_minutes: 0, completeness: 0)
  end
end
