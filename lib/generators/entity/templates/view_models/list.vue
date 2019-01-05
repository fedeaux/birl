<template lang="pug">
.entity-list.<%= underscore_name %>-list.default-container
  <%= plural_underscore_name %>-list-item(v-for='<%= underscore_name %> in <%= plural_underscore_name %>' v-if='<%= plural_underscore_name %>' :<%= underscore_name %>='<%= underscore_name %>' :key='<%= underscore_name %>.id')
  entity-list-empty(v-if='!<%= plural_underscore_name %> || <%= plural_underscore_name %>.length == 0')
</template>

<script lang="coffee">
export default
  props:
    <%= plural_underscore_name %>:
      default: null
</script>
