json.extract! session, :id, :name

json.progressions do
  json.array! session.progressions, :id, :name
end
