<template lang="pug">
.entity-manager.progressions-manager.default-container
  .entity-manager-form(v-if='form_progression')
    progressions-form(v-model='form_progression'
                      @save='saveFormProgression()'
                      @cancel='clearFormProgression()')

  .entity-manager-list(v-else)
    #new-progression-button.ui.primary.top.attached.fluid.small.icon.button(@click='newProgression')
      | Add

    progressions-list(:progressions='progressions'
                      :allow_actions='true'
                      @edit='editProgression($event)'
                      @destroy='destroyProgression($event)')
</template>

<script lang="coffee">
import ProgressionsResource from '../../resources/progressions_resource'
import Progression from '../../models/progression'

export default
  props:
    context:
      default: -> {}

    parent_progressions: null

  data: ->
    progressions: null
    form_progression: null

  methods:
    editProgression: (data) ->
      @setFormProgression data.progression

    destroyProgression: (data) ->
      @progressions_resource.destroy data.progression, @progressionRemoved

    loadProgressions: ->
      @progressions_resource.index @progressionsLoaded, @context

    progressionsLoaded: (response) ->
      @progressions = response.progressions

    newProgression: ->
      @setFormProgression new Progression @context

    setFormProgression: (@form_progression) ->

    clearFormProgression: ->
      @setFormProgression null

    progressionIndex: (progression_id) ->
      for index, progression of @progressions
        return index if progression.id == progression_id

      -1

    saveFormProgression: ->
      @progressions_resource.save @form_progression, @progressionSaved

    addProgression: (progression) ->
      index = @progressionIndex progression.id

      if index == -1
        @progressions.push progression
        return

      Vue.set @progressions, index, progression

    progressionSaved: (data) ->
      @addProgression data.progression
      @clearFormProgression()

    progressionRemoved: (data) ->
      index = @progressionIndex data.progression.id
      return if index == -1
      @progressions.splice index, 1

  mounted: ->
    @progressions_resource = new ProgressionsResource

    if @parent_progressions
      @progressions = @parent_progressions
      return

    @loadProgressions()
</script>
