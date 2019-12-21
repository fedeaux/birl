<template lang="pug">
.entity-edit.session-edit.default-container
  .entity-display
    .entity-display-main Edit Session

  sessions-form(v-model='session'
                v-if='session'
                @save='saveSession()'
                @cancel='sessionDone()')
</template>

<script lang="coffee">

import SessionsResource from '../../resources/sessions_resource'
import Session from '../../models/session'

export default
  data: ->
    session: null

  methods:
    loadSession: ->
      @sessions_resource.get @session_id, @sessionLoaded

    sessionLoaded: (response) ->
      @session = response.session

    saveSession: ->
      @sessions_resource.save @session, @sessionDone

    sessionDone: ->
      @$router.push @session.path()

  computed:
    session_id: ->
      @$route.params.id

  mounted: ->
    @sessions_resource = new SessionsResource
    @loadSession()
</script>
