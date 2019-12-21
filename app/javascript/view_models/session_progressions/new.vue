<template lang="pug">
.entity-new.session-progression-new.default-container
  .entity-display
    .entity-display-main New Session Progression

  session-progressions-form(v-model='session_progression'
                            @save='saveSessionProgression'
                            @cancel='back')
</template>

<script lang="coffee">

import SessionProgressionsResource from '../../resources/session_progressions_resource'
import SessionProgression from '../../models/session_progression'

export default
  data: ->
    session_progression: new SessionProgression

  methods:
    saveSessionProgression: ->
      @session_progressions_resource.save @session_progression, @saved

    saved: (data) ->
      @$router.push data.session_progression.path()

    back: ->
      @$router.push @session_progression.collectionPath()

  mounted: ->
    @session_progressions_resource = new SessionProgressionsResource
</script>
