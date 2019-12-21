json.listers do
  json.partial! 'api/v1/listers/show', collection: @listers, as: :lister
end
