<template lang="pug">
.entity-index.progressions-index.default-container
  progressions-list(:progressions='progressions')
</template>

<script lang="coffee">
import ProgressionsResource from '../../resources/progressions_resource'

export default
  data: ->
    progressions: null

  methods:
    loadProgressions: ->
      @progressions_resource.index @progressionsLoaded

    progressionsLoaded: (response) ->
      @progressions = response.progressions

  mounted: ->
    @progressions_resource = new ProgressionsResource
    @loadProgressions()
</script>
