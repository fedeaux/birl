json.tags do
  json.partial! 'api/v1/tags/show', collection: @tags, as: :tag
end
