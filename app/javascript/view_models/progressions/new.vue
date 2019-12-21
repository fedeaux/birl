<template lang="pug">
.entity-new.progression-new.default-container
  .entity-display
    .entity-display-main New Progression

  progressions-form(v-model='progression'
                    @save='saveProgression'
                    @cancel='back')
</template>

<script lang="coffee">

import ProgressionsResource from '../../resources/progressions_resource'
import Progression from '../../models/progression'

export default
  data: ->
    progression: new Progression

  methods:
    saveProgression: ->
      @progressions_resource.save @progression, @saved

    saved: (data) ->
      @$router.push data.progression.path()

    back: ->
      @$router.push @progression.collectionPath()

  mounted: ->
    @progressions_resource = new ProgressionsResource
</script>
