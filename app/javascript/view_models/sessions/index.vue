<template lang="pug">
sessions-manager.sessions-index(:parent_sessions='sessions')
</template>

<script lang="coffee">
import SessionsResource from '../../resources/sessions_resource'

export default
  data: ->
    sessions: null

  methods:
    loadSessions: ->
      @sessions_resource.index @sessionsLoaded

    sessionsLoaded: (response) ->
      @sessions = response.sessions

  mounted: ->
    @sessions_resource = new SessionsResource
    @loadSessions()
</script>
