json.training do
  json.partial! 'api/v1/trainings/show', training: @training
end
