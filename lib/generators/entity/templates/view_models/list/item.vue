<template lang="pug">
.entity-list-item-wrapper.<%= underscore_name %>-list-item-wrapper
  router-link.entity-list-item.<%= underscore_name %>-list-item(:to='<%= underscore_name %>.path()')
    | {{ <%= underscore_name %>.name }}

  entity-list-item-divider
</template>

<script lang="coffee">

export default
  props:
    <%= underscore_name %>:
      required: true
</script>
