<template lang="pug">
.entity-list-item-wrapper.entry-list-item-wrapper
  .entity-list-item.entry-list-item
    | {{ entry.values }}

  entity-list-item-divider
</template>

<script lang="coffee">

export default
  props:
    entry:
      required: true
</script>
