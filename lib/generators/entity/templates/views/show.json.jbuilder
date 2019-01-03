json.<%= underscore_name %> do
  json.partial! 'api/v1/<%= plural_underscore_name %>/show', <%= underscore_name %>: @<%= underscore_name %>
end
