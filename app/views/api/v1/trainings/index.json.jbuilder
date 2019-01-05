json.trainings do
  json.partial! 'api/v1/trainings/show', collection: @trainings, as: :training
end
