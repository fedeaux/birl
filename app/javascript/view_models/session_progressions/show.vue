<template lang="pug">
.entity-show-wrapper.session-progressions-show-wrapper.default-container(v-if='session_progression')
  .entity-show.session-progressions-show
    session-progressions-display(:session_progression='session_progression')
      shared-link.entity-show-header-actions(:to='session_progression.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  h3 Progression
  progressions-list-item(:progression='progression')
  //- BrainDamage: Body End

  h3 Session
  sessions-list-item(:session='session')
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import SessionProgressionsResource from '../../resources/session_progressions_resource'

export default
  props:
    parent_session_progression: null
    session_progression_id:
      default: null

  data: ->
    session_progression: null

  methods:
    loadSessionProgression: ->
      return unless @session_progression_id
      @session_progressions_resource.get @session_progression_id, @sessionProgressionLoaded

    sessionProgressionLoaded: (response) ->
      @session_progression = response.session_progression

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @session_progression = @parent_session_progression if @parent_session_progression
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    session_progression_id:
      immediate: true
      handler: ->
        @session_progressions_resource ?= new SessionProgressionsResource
        @loadSessionProgression()
</script>
