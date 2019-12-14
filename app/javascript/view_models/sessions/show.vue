<template lang="pug">
.entity-show-wrapper.sessions-show-wrapper.default-container(v-if='session')
  .entity-show.sessions-show
    sessions-display(:session='session')
      router-link.entity-show-header-actions(:to='session.editPath()')
        i.edit.icon

  .default-container
    .ui.green.message(v-if='session.complete')
      | Completed! Good work :)

  progressions-manager(:parent_progressions='session.progressions')

  shared-footer
    .ui.two.buttons
      .ui.fluid.basic.icon.button(@click='$emit("forceReload")' v-if='force_reloadable')
        i.refresh.icon
        |  Force Reload

      .ui.fluid.primary.icon.button(@click='startSession' v-if='!session.started')
        | Start
        | &nbsp;
        i.play.icon
</template>

<script lang="coffee">
import SessionsResource from '../../resources/sessions_resource'

export default
  props:
    parent_session: null
    force_reloadable: false

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
