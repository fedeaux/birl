<template lang="pug">
router-link.progression-list-item-contents(:to='progression.path()')
  | {{ progression.name }}
  .entity-list-item-detail(v-if='progression.last_entry_at')
    | {{ progression.last_entry_at.fromNow() }}

  .entity-list-item-detail(v-else)
    | Never trained
</template>

<script lang="coffee">
  export default
    props:
      progression:
        required: true
</script>
