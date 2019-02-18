<template lang="pug">
.entity-list.<%= underscore_name %>-list.default-container
  <%= plural_underscore_name %>-list-item(v-for='<%= underscore_name %> in <%= plural_underscore_name %>'
  <%= plural_underscore_name_as_spaces %>           v-if='<%= plural_underscore_name %>'
  <%= plural_underscore_name_as_spaces %>           :<%= underscore_name %>='<%= underscore_name %>'
  <%= plural_underscore_name_as_spaces %>           :allow_actions='allow_actions'
  <%= plural_underscore_name_as_spaces %>           :key='<%= underscore_name %>.id'
  <%= plural_underscore_name_as_spaces %>           @edit='$emit("edit", { <%= underscore_name %>: <%= underscore_name %> })'
  <%= plural_underscore_name_as_spaces %>           @destroy='$emit("destroy", { <%= underscore_name %>: <%= underscore_name %> })')

  entity-list-empty(v-if='!<%= plural_underscore_name %> || <%= plural_underscore_name %>.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    <%= plural_underscore_name %>:
      default: null
</script>
