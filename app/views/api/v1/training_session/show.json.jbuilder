json.training_session do
  json.partial! 'api/v1/training_sessions/show', training_session: @training_session
end
