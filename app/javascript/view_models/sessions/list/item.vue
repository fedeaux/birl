<template lang="pug">
.entity-list-item-wrapper.session-list-item-wrapper
  router-link.entity-list-item.session-list-item(:to='session.path()')
    | [{{ session.human_weekday }}]
    | {{ session.name }}
    .detail
      | {{ session.updated_at.fromNow() }}

  entity-list-item-divider
</template>

<script lang="coffee">

export default
  props:
    session:
      required: true
</script>
