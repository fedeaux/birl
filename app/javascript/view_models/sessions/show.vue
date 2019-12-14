<template lang="pug">
.entity-show-wrapper.sessions-show-wrapper.default-container(v-if='session')
  .entity-show.sessions-show
    sessions-display(:session='session')
      router-link.entity-show-header-actions(:to='session.editPath()')
        i.edit.icon

  .default-container(v-if='session.done_today')
    br
    .ui.green.message
      | Completed! Good work :)
    br

  progressions-manager(:parent_progressions='session.progressions')

  shared-footer
    .ui.two.buttons
      .ui.fluid.basic.icon.button(@click='$emit("forceReload")' v-if='force_reloadable')
        i.refresh.icon
        |  Force Reload

      .ui.fluid.primary.icon.button(@click='executeNextProgression' v-if='!session.done_today')
        template(v-if='session.started_today')
          | Continue
        template(v-else)
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

    executeNextProgression: ->
      @setCurrentSession @session
      for progression in @session.progressions
        unless progression.done_today
          @$router.push progression.path()
          return

  mounted: ->
    if @parent_session
      @session = @parent_session
      return

    @sessions_resource = new SessionsResource
    @session_id = @$route.params.id
    @loadSession()
</script>
