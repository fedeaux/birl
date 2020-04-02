json.weeks do
  json.partial! 'api/v1/weeks/show', collection: @weeks, as: :week
end
