json.partial! 'api/v1/memes/fields', meme: meme

json.tags do
  json.partial! 'api/v1/tags/show', collection: meme.tags, as: :tag
end
