<template lang="pug">
.entity-edit.progression-edit.default-container
  progressions-form(v-model='progression'
                    v-if='progression'
                    @save='saveProgression()'
                    @cancel='progressionDone()')
</template>

<script lang="coffee">

import ProgressionsResource from '../../resources/progressions_resource'
import Progression from '../../models/progression'

export default
  data: ->
    progression: null

  methods:
    loadProgression: ->
      @progressions_resource.get @progression_id, @progressionLoaded

    progressionLoaded: (response) ->
      @progression = response.progression

    saveProgression: ->
      @progressions_resource.save @progression, @progressionDone

    progressionDone: ->
      @$router.push @progression.path()

  computed:
    progression_id: ->
      @$route.params.id

  mounted: ->
    @progressions_resource = new ProgressionsResource
    @loadProgression()
</script>
