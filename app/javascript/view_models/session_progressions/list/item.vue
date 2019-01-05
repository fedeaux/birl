<template lang="pug">
.entity-list-item-wrapper.session_progression-list-item-wrapper
  router-link.entity-list-item.session_progression-list-item(:to='session_progression.path()')
    | {{ session_progression.name }}

  entity-list-item-divider
</template>

<script lang="coffee">

export default
  props:
    session_progression:
      required: true
</script>
