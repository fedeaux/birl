<template lang="pug">
.entity-edit.session-edit.default-container(v-if='sessions')
  sessions-manager(:sessions='sessions')

  .default-container
    .ui.two.column.centered.grid
</template>

<script lang="coffee">
import SessionsResource from '../../resources/sessions_resource'

export default
  data: ->
    sessions: null

  methods:
    loadSessions: ->
      @sessions_resource.todays @sessionsLoaded

    sessionsLoaded: (response) ->
      @sessions = response.sessions
      # @setCurrentSession @session

    forceReload: ->
      localStorage.clear()
      @loadSessions()

  mounted: ->
    @sessions_resource = new SessionsResource
    @loadSessions()
</script>
