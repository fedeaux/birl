<template lang="pug">
  .entry-list-item-contents
    .entry-list-item-variables {{ entry.variables }}
    .entry-list-item-values {{ entry.values }}
    .entity-list-item-detail {{ entry.created_at.fromNow() }}
</template>

<script lang="coffee">
  export default
    props:
      entry:
        required: true
</script>
