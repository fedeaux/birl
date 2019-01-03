json.progressions do
  json.partial! 'api/v1/progressions/show', collection: @progressions, as: :progression
end
