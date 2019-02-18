json.extract! group, :id, :name

json.exercises do
  json.array! group.exercises, partial: 'api/v1/exercises/show', as: :exercise
end
