json.goals_periods do
  json.partial! 'api/v1/goals_periods/attributes', collection: @goals_periods, as: :goals_period
end
