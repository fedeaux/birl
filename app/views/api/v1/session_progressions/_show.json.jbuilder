json.partial! 'api/v1/session_progressions/fields', session_progression: session_progression

json.progression do
  json.partial! 'api/v1/progressions/fields', progression: session_progression.progression
end

json.session do
  json.partial! 'api/v1/sessions/fields', session: session_progression.session
end
