json.<%= plural_underscore_name %> do
  json.partial! 'api/v1/<%= plural_underscore_name %>/show', collection: @<%= plural_underscore_name %>, as: :<%= underscore_name %>
end
