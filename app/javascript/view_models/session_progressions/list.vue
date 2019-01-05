<template lang="pug">
.entity-list.session_progression-list.default-container
  session_progressions-list-item(v-for='session_progression in session_progressions' v-if='session_progressions' :session_progression='session_progression' :key='session_progression.id')
  entity-list-empty(v-if='!session_progressions || session_progressions.length == 0')
</template>

<script lang="coffee">
export default
  props:
    session_progressions:
      default: null
</script>
