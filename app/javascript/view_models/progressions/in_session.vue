<template lang="pug">
.progressions-in-session.ui.three.column.grid
  .progressions-in-session-prev.column
    router-link(v-if='prev_progression' :to='prev_progression.path()')
      | &larr;
      | {{ prev_progression.exercise_name }}

  .progressions-in-session-session.column(v-if='current_session')
    router-link(:to='current_session.path()')
      h3 Session
      | {{ current_session.name }}

  .progressions-in-session-next.column
    router-link(v-if='next_progression' :to='next_progression.path()')
      | {{ next_progression.exercise_name }}
      | &rarr;

    .ui.primary.button(v-if='!next_progression && prev_progression' @click='finishSession')
      | Finish

</template>

<script lang="coffee">
import Session from '../../models/session'

export default
  props:
    current_progression_id:
      type: Number

  data: ->
    next_progression: null
    prev_progression: null

  methods:
    finishSession: ->
      if @current_session
        @$router.push @current_session.path()
        return

      @$router.push '/'

  watch:
    current_progression_id:
      immediate: true
      handler: ->
        @next_progression = null
        @prev_progression = null
        passed_current = false

        return unless @current_session

        for progression in @current_session.progressions
          if passed_current
            @next_progression = progression
            return

          passed_current = progression.id == @current_progression_id

          unless passed_current
            @prev_progression = progression

        unless passed_current
          @next_progression = null
          @prev_progression = null

</script>
