json.entries do
  json.partial! 'api/v1/entries/show', collection: @entries, as: :entry
end
