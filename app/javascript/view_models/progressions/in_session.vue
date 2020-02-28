<template lang="pug">
.progressions-in-session.ui.three.column.grid
  .progressions-in-session-prev.column
    shared-link(v-if='prev_progression' :to='prev_progression.executePath()')
      | &larr;
      | {{ prev_progression.exercise_name }}

  .progressions-in-session-session.column(v-if='current_session')
    shared-link(:to='current_session.path()')
      h3 Session
      | {{ current_session.name }}

  .progressions-in-session-next.column
    shared-link(v-if='next_progression' :to='next_progression.executePath()')
      | {{ next_progression.exercise_name }}
      | &rarr;

    .ui.primary.button(v-if='!next_progression && prev_progression' @click='finishSession')
      | Finish

</template>

<script lang="coffee">
import SessionsResource from '../../resources/sessions_resource'
import Session from '../../models/session'

export default
  props:
    current_progression_id:
      type: Number

  data: ->
    next_progression: null
    prev_progression: null
    sessions_resource: null
    chronometer: null

  methods:
    navigateToNext: ->
      if @next_progression
        @$router.push @next_progression.executePath()
      else
        @finishSession()

    finishSession: ->
      return @currentSessionUpdated() unless @current_session

      @sessions_resource ?= new SessionsResource
      @current_session.executed_at = moment()
      @sessions_resource.update @current_session, @currentSessionUpdated

    currentSessionUpdated: ->
      @$router.push '/'

    clockTick: ->
      return unless @current_session and @current_session.started_at
      seconds = @$options.filters.seconds(moment.duration(moment().diff(@current_session.started_at)).asSeconds())

      Global.events.$emit 'SetTitle', title: "#{seconds} - #{@current_session.name}"

  created: ->
    return unless @current_session and @current_session.started_at

    @chronometer = setInterval @clockTick, 1000

  beforeDestroy: ->
    clearInterval @chronometer
    Global.events.$emit 'SetTitle', title: null

  watch:
    current_progression_id:
      immediate: true
      handler: ->
        @next_progression = null
        @prev_progression = null
        passed_current = false

        return unless @current_session && @current_session.progressions

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
