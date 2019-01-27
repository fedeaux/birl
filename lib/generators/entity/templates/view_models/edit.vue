<template lang="pug">
.entity-edit.<%= underscore_name %>-edit.default-container
  <%= plural_underscore_name %>-form(:<%= underscore_name %>_id='<%= underscore_name %>_id')
</template>

<script lang="coffee">
export default
  computed:
    <%= underscore_name %>_id: ->
      @$route.params.id
</script>
