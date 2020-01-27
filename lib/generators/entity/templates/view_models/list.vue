<template lang="pug">
.entity-list.<%= dash_name %>-list.default-container.header-contents-footer
  .header-contents-footer-header
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .header-contents-footer-contents
    <%= plural_dash_name %>-list-item(v-for='<%= underscore_name %> in displayable_<%= plural_underscore_name %>'
    <%= plural_dash_name_as_spaces %>           v-if='<%= plural_underscore_name %>'
    <%= plural_dash_name_as_spaces %>           :<%= underscore_name %>='<%= underscore_name %>'
    <%= plural_dash_name_as_spaces %>           :allow_actions='allow_actions'
    <%= plural_dash_name_as_spaces %>           :key='<%= underscore_name %>.id'
    <%= plural_dash_name_as_spaces %>           @edit='$emit("edit", { <%= underscore_name %>: <%= underscore_name %> })'
    <%= plural_dash_name_as_spaces %>           @destroy='$emit("destroy", { <%= underscore_name %>: <%= underscore_name %> })')

    entity-list-empty(v-if='!<%= plural_underscore_name %> || <%= plural_underscore_name %>.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    <%= plural_underscore_name %>:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (<%= underscore_name %>) ->
      (@filter.text == '' or <%= underscore_name %>.<%= filterable_field %>.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_<%= plural_underscore_name %>: ->
      return [] unless @<%= plural_underscore_name %>

      (<%= underscore_name %> for <%= underscore_name %> in @<%= plural_underscore_name %> when @matchFilters <%= underscore_name %>)
</script>
