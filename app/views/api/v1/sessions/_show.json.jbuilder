json.partial! 'api/v1/sessions/fields', session: session

json.session_progressions do
  json.partial! 'api/v1/session_progressions/fields', collection: session.session_progressions, as: :session_progression
end

json.progressions do
  json.partial! 'api/v1/progressions/fields', collection: session.progressions, as: :progression
end
