json.goal_entries do
  json.partial! 'api/v1/goal_entries/show', collection: @goal_entries, as: :goal_entry
end
