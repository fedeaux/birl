json.days do
  json.partial! 'api/v1/days/show', collection: @days, as: :day
end
