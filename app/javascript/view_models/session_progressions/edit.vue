<template lang="pug">
.entity-edit.session_progression-edit.default-container
  .entity-display
    .entity-display-main Edit Session Progression

  session-progressions-form(v-model='session_progression'
                            v-if='session_progression'
                            @save='saveSessionProgression()'
                            @cancel='sessionProgressionDone()')
</template>

<script lang="coffee">

import SessionProgressionsResource from '../../resources/session_progressions_resource'
import SessionProgression from '../../models/session_progression'

export default
  data: ->
    session_progression: null

  methods:
    loadSessionProgression: ->
      @session_progressions_resource.get @session_progression_id, @sessionProgressionLoaded

    sessionProgressionLoaded: (response) ->
      @session_progression = response.session_progression

    saveSessionProgression: ->
      @session_progressions_resource.save @session_progression, @sessionProgressionDone

    sessionProgressionDone: ->
      @$router.push @session_progression.path()

  computed:
    session_progression_id: ->
      @$route.params.id

  mounted: ->
    @session_progressions_resource = new SessionProgressionsResource
    @loadSessionProgression()
</script>
