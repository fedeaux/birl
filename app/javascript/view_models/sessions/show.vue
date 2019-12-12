<template lang="pug">
.entity-show-wrapper.sessions-show-wrapper.default-container.with-footer(v-if='session')
  .entity-show.sessions-show
    h1.entity-show-header
      | {{ session.name }}
      | [{{ session.human_weekday }}]

  .ui.green.message(v-if='session.complete')
    | Completed! Good work :)

  progressions-manager(:parent_progressions='session.progressions')

  .ui.three.column.centered.grid
    .column
      .ui.huge.fluid.primary.button(@click='startSession') Start

  shared-footer(v-if='session')
    router-link.ui.fluid.red.basic.button(:to='session.editPath()')
      | Edit
</template>

<script lang="coffee">
import SessionsResource from '../../resources/sessions_resource'
import Database from '../../lib/database'

export default
  props:
    parent_session: null

  data: ->
    session: null
    session_id: null

  methods:
    loadSession: ->
      @sessions_resource.get @session_id, @sessionLoaded

    sessionLoaded: (response) ->
      @session = response.session

    startSession: ->
      (new Database).set 'current_session', @session
      @$router.push @session.progressions[0].path()

  mounted: ->
    if @parent_session
      @session = @parent_session
      console.log "session", @session
      return

    @sessions_resource = new SessionsResource
    @session_id = @$route.params.id
    @loadSession()
</script>
