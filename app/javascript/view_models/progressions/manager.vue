<template lang="pug">
.entity-manager.progressions-manager.default-container
  progressions-list(:progressions='progressions')
</template>

<script lang="coffee">
import ProgressionsResource from '../../resources/progressions_resource'

export default
  props:
    context:
      default: -> {}

  data: ->
    progressions: null

  methods:
    loadProgressions: ->
      @progressions_resource.index @progressionsLoaded, @context

    progressionsLoaded: (response) ->
      @progressions = response.progressions

  mounted: ->
    @progressions_resource = new ProgressionsResource
    @loadProgressions()
</script>
