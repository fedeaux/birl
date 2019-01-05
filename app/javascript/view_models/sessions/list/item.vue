<template lang="pug">
.entity-list-item-wrapper.session-list-item-wrapper
  router-link.entity-list-item.session-list-item(:to='session.path()')
    | {{ session.name }}

  entity-list-item-divider
</template>

<script lang="coffee">

export default
  props:
    session:
      required: true
</script>
