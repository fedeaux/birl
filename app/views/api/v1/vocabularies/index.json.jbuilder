json.vocabularies do
  json.partial! 'api/v1/vocabularies/show', collection: @vocabularies, as: :vocabulary
end
