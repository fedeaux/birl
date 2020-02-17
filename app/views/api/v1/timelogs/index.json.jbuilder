json.timelogs do
  json.partial! 'api/v1/timelogs/show', collection: @timelogs, as: :timelog
end
