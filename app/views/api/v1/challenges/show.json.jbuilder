json.challenge do
  json.partial! 'api/v1/challenges/show', challenge: @challenge
end
