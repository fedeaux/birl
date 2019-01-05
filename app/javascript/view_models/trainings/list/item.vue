<template lang="pug">
.entity-list-item-wrapper.training-list-item-wrapper
  router-link.entity-list-item.training-list-item(:to='training.path()')
    | {{ training.name }}

  entity-list-item-divider
</template>

<script lang="coffee">

export default
  props:
    training:
      required: true
</script>
