json.extract! goals_period, :name

json.items do
  json.partial! 'api/v1/goal_entries/show', collection: goals_period.goal_entries, as: :goal_entry
end
