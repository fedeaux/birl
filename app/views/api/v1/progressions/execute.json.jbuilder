json.progression do
  json.partial! 'api/v1/progressions/show', progression: @progression

  if @new_entry
    json.new_entry do
      json.partial! 'api/v1/entries/show', entry: @new_entry
    end
  end

  if @todays_entry
    json.todays_entry do
      json.partial! 'api/v1/entries/show', entry: @todays_entry
    end
  end

  json.entries do
    json.partial! 'api/v1/entries/show', collection: @entries, as: :entry
  end
end
