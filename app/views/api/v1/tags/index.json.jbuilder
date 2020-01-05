json.tags do
  json.partial! 'api/v1/tags/hierarchy', collection: @tags, as: :tag
end
