<template lang="pug">
.entity-list-item-wrapper.challenge-list-item-wrapper
  router-link.entity-list-item.challenge-list-item(:to='challenge.path()')
    | {{ challenge.name }}

  entity-list-item-divider
</template>

<script lang="coffee">

export default
  props:
    challenge:
      required: true
</script>
