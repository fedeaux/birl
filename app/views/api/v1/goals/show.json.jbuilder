json.goal do
  json.partial! 'api/v1/goals/show', goal: @goal
end
