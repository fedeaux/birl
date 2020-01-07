json.tag_taggable do
  json.partial! 'api/v1/tag_taggables/show', tag_taggable: @tag_taggable
end
