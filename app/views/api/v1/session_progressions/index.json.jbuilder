json.session_progressions do
  json.partial! 'api/v1/session_progressions/show', collection: @session_progressions, as: :session_progression
end
