<template lang="pug">
.entity-edit.session-edit.default-container(v-if='session')
  sessions-show(:parent_session='session' @forceReload='forceReload' :force_reloadable='true')

  .default-container
    .ui.two.column.centered.grid
</template>

<script lang="coffee">
import Session from '../../models/session'
import SessionsResource from '../../resources/sessions_resource'

export default
  data: ->
    session: null

  methods:
    loadSession: ->
      @sessions_resource.todays @sessionLoaded

    sessionLoaded: (response) ->
      @session = response.session
      @setCurrentSession @session

    forceReload: ->
      localStorage.clear()
      @loadSession()

  mounted: ->
    @sessions_resource = new SessionsResource
    @loadSession()
</script>
