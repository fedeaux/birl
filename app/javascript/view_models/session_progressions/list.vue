<template lang="pug">
.entity-list.session-progression-list.default-container
  session-progressions-list-item(v-for='session_progression in session_progressions'
                                 v-if='session_progressions'
                                 :session_progression='session_progression'
                                 :allow_actions='allow_actions'
                                 :key='session_progression.id'
                                 @edit='$emit("edit", { session_progression: session_progression })'
                                 @destroy='$emit("destroy", { session_progression: session_progression })')

  entity-list-empty(v-if='!session_progressions || session_progressions.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    session_progressions:
      default: null
</script>
