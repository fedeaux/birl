class YesOrNoGoal < Goal
  def goal_entry_default_meta
    entry_meta.merge(answer: nil)
  end
end
