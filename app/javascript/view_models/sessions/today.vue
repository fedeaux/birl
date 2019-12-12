<template lang="pug">
.entity-edit.session-edit.default-container
  sessions-show(:parent_session='session' v-if='session')
</template>

<script lang="coffee">
import SessionsResource from '../../resources/sessions_resource'
import Database from '../../lib/database'

export default
  data: ->
    session: null

  methods:
    loadSession: ->
      @sessions_resource.todays @sessionLoaded

    sessionLoaded: (response) ->
      @session = response.session

      # Some man just want to see the world burn
      (new Database).set 'current_session', @session

  mounted: ->
    @sessions_resource = new SessionsResource
    @loadSession()
</script>
