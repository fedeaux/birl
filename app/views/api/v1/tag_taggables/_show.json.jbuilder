json.partial! 'api/v1/tag_taggables/fields', tag_taggable: tag_taggable

json.tag do
  json.partial! 'api/v1/tags/fields', tag: tag_taggable.tag
end
