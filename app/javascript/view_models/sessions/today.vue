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
      loaded_session = response.session
      current_session = @current_session

      if current_session and current_session.id == loaded_session.id
        @session = current_session
      else
        @session = loaded_session

      @setCurrentSession @session
      @$forceUpdate()

    forceReload: ->
      localStorage.clear()
      @loadSession()

  mounted: ->
    @sessions_resource = new SessionsResource
    @loadSession()
</script>
