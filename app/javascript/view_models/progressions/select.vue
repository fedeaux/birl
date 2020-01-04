<template lang="pug">
  shared-modal(v-if='form_progression' title='New Progression')
    progressions-form(v-model='form_progression'
                   @save='saveFormProgression()'
                   @cancel='clearFormProgression()')

  sui-dropdown(:options='progressions_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Progression'
               v-else
               v-model='selected_progression_id')

</template>

<script lang="coffee">
import ProgressionsManagerMixin from '../../mixins/progressions/manager'

export default
  mixins: [ProgressionsManagerMixin]

  model:
    prop: 'progression_id'

  props:
    progression_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_progression_id: null

  methods:
    progressionAdded: (index, progression) ->
      @selectProgression progression

    selectProgression: (progression) ->
      @selected_progression_id = parseInt progression.id

  computed:
    loading: ->
      !@progressions

    progressions_as_options: ->
      return [] unless @progressions
      { key: progression.id, value: progression.id, text: progression.name } for progression in @progressions

  watch:
    selected_progression_id: ->
      selected_progression_id = parseInt @selected_progression_id

      unless isNaN selected_progression_id
        @$emit 'input', selected_progression_id
        return

      @newProgression name: @selected_progression_id

    progression_id:
      immediate: true
      handler: ->
        return unless @progression_id
        @selected_progression_id = parseInt @progression_id

</script>
