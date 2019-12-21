json.extract! session, :id, :name, :weekday, :human_weekday, :updated_at, :done_today, :started_today, :last_entry_at

json.session_progressions do
  json.partial! 'api/v1/session_progressions/show', collection: session.session_progressions, as: :session_progression
end

json.progressions do
  json.partial! 'api/v1/progressions/show', collection: session.progressions, as: :progression
end
