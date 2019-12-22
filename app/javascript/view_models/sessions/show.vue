<template lang="pug">
.entity-show-wrapper.sessions-show-wrapper.default-container(v-if='session')
  .entity-show.sessions-show
    sessions-display(:session='session')
      router-link.entity-show-header-actions(:to='session.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  .default-container(v-if='session.done_today')
    br
    .ui.green.message
      | Completed! Good work :)
    br

  .muted-text These are the session progressions, not the progressions themselves
  session-progressions-manager(:context='{ session_id: session.id }'
                               :parent_session_progressions='session.session_progressions')

  shared-footer
    .ui.two.column.centered.grid
      .column
        .ui.fluid.primary.icon.button(@click='executeNextProgression' v-if='!session.done_today')
          template(v-if='session.started_today')
            | Continue
          template(v-else)
            | Start
          | &nbsp;
          i.play.icon
  //- BrainDamage: Body End
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

    # BrainDamage: Methods Start
    executeNextProgression: ->
      @setCurrentSession @session
      for progression in @session.progressions
        unless progression.done_today
          @$router.push progression.executePath()
          return
    # BrainDamage: Methods End

  mounted: ->
    @session = @parent_session if @parent_session
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    '$route.params.id':
      immediate: true
      handler: ->
        @sessions_resource ?= new SessionsResource
        @session_id = parseInt @$route.params.id
        @loadSession()
</script>
