<template lang="pug">
.entity-list-item-wrapper.entry-list-item-wrapper
  router-link.entity-list-item.entry-list-item(:to='entry.path()')
    | {{ entry.name }}

  entity-list-item-divider
</template>

<script lang="coffee">

export default
  props:
    entry:
      required: true
</script>
