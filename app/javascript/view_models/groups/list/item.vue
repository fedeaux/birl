<template lang="pug">
.group-list-item-wrapper
  .group-list-item
    .group-list-item-title {{ group.name }}
    exercises-list(:exercises='group.exercises')

  entity-list-item-divider
</template>

<script lang="coffee">

export default
  props:
    group:
      required: true
</script>
