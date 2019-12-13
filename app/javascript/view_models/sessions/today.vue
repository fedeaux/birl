<template lang="pug">
.entity-edit.session-edit.default-container(v-if='session')
  sessions-show(:parent_session='session')

  .default-container
    .ui.two.column.centered.grid
      .column
        .ui.fluid.basic.icon.button(@click='forceReload')
          i.refresh.icon
          |  Force Reload
</template>

<script lang="coffee">
import Session from '../../models/session'
import SessionsResource from '../../resources/sessions_resource'

export default
  data: ->
    session: null

  methods:
    loadSession: ->
      @load()
      @sessions_resource.todays @sessionLoaded

    sessionLoaded: (response) ->
      @loaded()
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
      @load()
      @loadSession()

  mounted: ->
    @sessions_resource = new SessionsResource
    @loadSession()
</script>
