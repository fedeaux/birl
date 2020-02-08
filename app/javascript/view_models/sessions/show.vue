<template lang="pug">
.entity-show-wrapper.sessions-show-wrapper.default-container(v-if='session')
  .header-contents-footer
    .entity-show.sessions-show.header-contents-footer-header
      sessions-display(:session='session')
        shared-link.entity-show-header-actions(:to='session.editPath()')
          i.edit.icon

    //- BrainDamage: Body Start
    .header-contents-footer-contents.header-contents-footer
      .header-contents-footer-header
        .default-container(v-if='session.done_today')
          br
          .ui.green.message
            | Completed! Good work :)
          br

        .muted-text These are the session progressions, not the progressions themselves

      .header-contents-footer-contents
        session-progressions-manager(:context='{ session_id: session.id }'
                                     :parent_session_progressions='session.session_progressions')

    .header-contents-footer-footer.bottom-attached-footer.action-footer
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
    session_id:
      default: null

  data: ->
    session: null

  methods:
    loadSession: ->
      return unless @session_id
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

      @$router.push @session.progressions[0].executePath()
    # BrainDamage: Methods End

  mounted: ->
    @session = @parent_session if @parent_session
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    session_id:
      immediate: true
      handler: ->
        @sessions_resource ?= new SessionsResource
        @loadSession()
</script>
