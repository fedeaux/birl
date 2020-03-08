json.goal_entry do
  json.partial! 'api/v1/goal_entries/show', goal_entry: @goal_entry
end
