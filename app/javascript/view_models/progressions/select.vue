<template lang="pug">
  sui-dropdown(:options='progressions_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               placeholder='Progression'
               v-model='selected_progression_id')
</template>

<script lang="coffee">
import ProgressionsResource from '../../resources/progressions_resource'

export default
  model:
    prop: 'progression_id'

  props:
    progression_id: null

  data: ->
    progressions: null
    selected_progression_id: null

  methods:
    loadProgressions: ->
      @progressions_resource.index @progressionsLoaded

    progressionsLoaded: (response) ->
      @progressions = response.progressions

    progressionIndex: (progression_id) ->
      for index, progression of @progressions
        return index if progression.id == progression_id

      -1

    getProgression: (progression_id) ->
      index = @progressionIndex progression_id
      return null if index == -1
      @progressions[index]

  computed:
    loading: ->
      !@progressions

    progressions_as_options: ->
      return [] unless @progressions
      { key: progression.id, value: progression.id, text: progression.name } for progression in @progressions

  watch:
    selected_progression_id: ->
      @$emit 'input', @selected_progression_id

    progression_id:
      immediate: true
      handler: ->
        return unless @progression_id
        @selected_progression_id = parseInt @progression_id

  mounted: ->
    @progressions_resource = new ProgressionsResource
    @loadProgressions()

</script>
