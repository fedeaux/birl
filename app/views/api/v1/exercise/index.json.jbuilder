json.exercises do
  json.partial! 'api/v1/exercises/show', collection: @exercises, as: :exercise
end
