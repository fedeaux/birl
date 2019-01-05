json.session do
  json.partial! 'api/v1/sessions/show', session: @session
end
