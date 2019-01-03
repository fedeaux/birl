<template lang="pug">
.entity-list-item-wrapper.progression-list-item-wrapper
  router-link.entity-list-item.progression-list-item(:to='progression.path()')
    | {{ progression.name }}

  entity-list-item-divider
</template>

<script lang="coffee">

export default
  props:
    progression:
      required: true
</script>
