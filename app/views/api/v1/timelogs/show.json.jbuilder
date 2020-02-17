json.timelog do
  json.partial! 'api/v1/timelogs/show', timelog: @timelog
end
