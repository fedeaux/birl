<template lang="pug">
.entity-show-wrapper.sessions-show-wrapper.default-container(v-if='session')
  .entity-show.sessions-show.default-container
    h1.entity-show-header
      | {{ session.name }}
      | [{{ session.human_weekday }}]

      router-link.entity-show-header-actions(:to='session.editPath()')
        i.edit.icon

  .default-container
    .ui.green.message(v-if='session.complete')
      | Completed! Good work :)

  progressions-manager(:parent_progressions='session.progressions')

  .ui.two.column.centered.grid(v-if='!session.started')
    .column
      .ui.fluid.huge.primary.icon.button(@click='startSession')
        | Start
        | &nbsp;
        i.play.icon
</template>

<script lang="coffee">
import SessionsResource from '../../resources/sessions_resource'

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
      @session.started = true
      @setCurrentSession @session
      @$router.push @session.progressions[0].path()

  mounted: ->
    if @parent_session
      @session = @parent_session
      return

    @sessions_resource = new SessionsResource
    @session_id = @$route.params.id
    @loadSession()
</script>
