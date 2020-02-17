json.partial! 'api/v1/timelogs/fields', timelog: timelog

if timelog.main_tag
  json.main_tag do
    json.partial! 'api/v1/tags/fields', tag: timelog.main_tag
  end
end
