<template lang="pug">
router-link.session-list-item-contents(:to='session.path()')
  | {{ session.name }}
  .entity-list-item-contents-detail
    | {{ session.human_weekday }}
    | &middot;
    | {{ session.updated_at.fromNow() }}
</template>

<script lang="coffee">
  export default
    props:
      session:
        required: true
</script>
