json.goals do
  json.partial! 'api/v1/goals/show', collection: @goals, as: :goal
end
