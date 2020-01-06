json.memes do
  json.partial! 'api/v1/memes/show', collection: @memes, as: :meme
end
