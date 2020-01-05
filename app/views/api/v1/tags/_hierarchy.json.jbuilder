json.partial! 'api/v1/tags/fields', tag: tag

json.children do
  json.partial! 'api/v1/tags/hierarchy', collection: tag.children, as: :tag
end
