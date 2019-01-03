<template lang="pug">
.entity-list-item-wrapper.exercise-list-item-wrapper
  router-link.entity-list-item.exercise-list-item(:to='exercise.path()')
    | {{ exercise.name }}

  entity-list-item-divider
</template>

<script lang="coffee">

export default
  props:
    exercise:
      required: true
</script>
