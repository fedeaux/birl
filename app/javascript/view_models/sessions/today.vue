<template lang="pug">
.entity-edit.session-edit.default-container
  sessions-show(:parent_session='session' v-if='session')
</template>

<script lang="coffee">
import Database from '../../lib/database'
import Session from '../../models/session'
import SessionsResource from '../../resources/sessions_resource'

export default
  data: ->
    session: null

  methods:
    loadSession: ->
      @sessions_resource.todays @sessionLoaded

    sessionLoaded: (response) ->
      loaded_session = response.session
      current_session = @currentSession()

      if current_session and current_session.id == loaded_session.id
        @session = current_session
      else
        @session = loaded_session

      # Some man just want to see the world burn
      (new Database).set 'current_session', @session

    currentSession: ->
      session_attributes = (new Database).get 'current_session'
      return null unless session_attributes
      new Session session_attributes

  mounted: ->
    @sessions_resource = new SessionsResource
    @loadSession()
</script>
