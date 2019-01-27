<template lang="pug">
.entity-manager.progressions-manager.default-container
  .entity-manager-form(v-if='form_progression')
    progressions-form(:original_progression='form_progression')

  .entity-manager-list(v-else)
    #new-progression-button.ui.primary.small.icon.button(@click='newProgression')
      i.add.icon
      | add
    progressions-list(:progressions='progressions')
</template>

<script lang="coffee">
import ProgressionsResource from '../../resources/progressions_resource'
import Progression from '../../models/progression'

export default
  props:
    context:
      default: -> {}

  data: ->
    progressions: null
    form_progression: null

  methods:
    loadProgressions: ->
      @progressions_resource.index @progressionsLoaded, @context

    progressionsLoaded: (response) ->
      @progressions = response.progressions
      @$nextTick ->
        $('#new-progression-button').click()

    newProgression: ->
      @setFormProgression new Progression(@context)

    setFormProgression: (@form_progression) ->

  mounted: ->
    @progressions_resource = new ProgressionsResource
    @loadProgressions()
</script>
