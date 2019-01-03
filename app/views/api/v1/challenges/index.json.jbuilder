json.challenges do
  json.partial! 'api/v1/challenges/show', collection: @challenges, as: :challenge
end
