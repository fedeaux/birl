json.session_progression do
  json.partial! 'api/v1/session_progressions/show', session_progression: @session_progression
end
