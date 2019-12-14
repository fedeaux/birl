<template lang="pug">
.entity-edit.session_progression-edit.default-container
  session_progressions-form(v-model='session_progression'
                            v-if='session_progression'
                            @save='saveSessionProgression()'
                            @cancel='session_progressionDone()')
</template>

<script lang="coffee">

import SessionProgressionsResource from '../../resources/session_progressions_resource'
import SessionProgression from '../../models/session_progression'

export default
  data: ->
    session_progression: null

  methods:
    loadSessionProgression: ->
      @session_progressions_resource.get @session_progression_id, @session_progressionLoaded

    session_progressionLoaded: (response) ->
      @session_progression = response.session_progression

    saveSessionProgression: ->
      @session_progressions_resource.save @session_progression, @session_progressionDone

    session_progressionDone: ->
      @$router.push @session_progression.path()

  computed:
    session_progression_id: ->
      @$route.params.id

  mounted: ->
    @session_progressions_resource = new SessionProgressionsResource
    @loadSessionProgression()
</script>
