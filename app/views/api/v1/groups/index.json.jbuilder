json.groups do
  json.partial! 'api/v1/groups/show', collection: @groups, as: :group
end
