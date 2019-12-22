json.extract! user, :id, :email, :current_context_id

if user.current_context
  json.current_context do
    json.partial! 'api/v1/contexts/show', context: user.current_context
  end
end
