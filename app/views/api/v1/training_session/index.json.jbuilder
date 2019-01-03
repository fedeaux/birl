json.training_sessions do
  json.partial! 'api/v1/training_sessions/show', collection: @training_sessions, as: :training_session
end
