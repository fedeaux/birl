json.sessions do
  json.partial! 'api/v1/sessions/show', collection: @sessions, as: :session
end
