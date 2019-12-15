json.contexts do
  json.partial! 'api/v1/contexts/show', collection: @contexts, as: :context
end
