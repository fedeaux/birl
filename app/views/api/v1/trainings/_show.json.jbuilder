json.extract! training, :id, :name, :user_id

json.sessions do
  json.partial! 'api/v1/sessions/show', training: @sessions, as: :session
end
