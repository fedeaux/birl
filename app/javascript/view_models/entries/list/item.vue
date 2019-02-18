<template lang="pug">
.entity-list-item-wrapper.entry-list-item-wrapper
  .entity-list-item.entry-list-item
    .entry-list-item-date {{ entry.created_at.fromNow() }}
    .entry-list-item-values {{ entry.values }}
    .entry-list-item-variables {{ entry.variables }}

  entity-list-item-divider
</template>

<script lang="coffee">

export default
  props:
    entry:
      required: true
</script>
