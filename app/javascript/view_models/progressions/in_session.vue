<template lang="pug">
.progressions-in-session.ui.two.column.grid
  .progressions-in-session-prev.column
    router-link(v-if='prev_progression' :to='prev_progression.path()')
      | &larr;
      | {{ prev_progression.name }}

  .progressions-in-session-next.column
    router-link(v-if='next_progression' :to='next_progression.path()')
      | {{ next_progression.name }}
      | &rarr;

</template>

<script lang="coffee">
import Database from '../../lib/database'
import Session from '../../models/session'

export default
  props: ['current_progression_id']

  data: ->
    next_progression: null
    prev_progression: null

  watch:
    current_progression_id:
      immediate: true
      handler: ->
        session_attributes = (new Database).get 'current_session'
        return null unless session_attributes
        session = new Session session_attributes
        passed_current = false
        @next_progression = null
        @prev_progression = null

        for progression in session.progressions
          if passed_current
            @next_progression = progression
            return

          passed_current = progression.id == @current_progression_id

          unless passed_current
            @prev_progression = progression

        null

</script>