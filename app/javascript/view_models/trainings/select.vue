<template lang="pug">
  shared-modal(v-if='form_training' title='New Training')
    trainings-form(v-model='form_training'
                   @save='saveFormTraining()'
                   @cancel='clearFormTraining()')

  sui-dropdown(:options='trainings_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Training'
               v-else
               v-model='selected_training_id')

</template>

<script lang="coffee">
import TrainingsManagerMixin from '../../mixins/trainings/manager'

export default
  mixins: [TrainingsManagerMixin]

  model:
    prop: 'training_id'

  props:
    training_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_training_id: null

  methods:
    trainingAdded: (index, training) ->
      @selectTraining training

    selectTraining: (training) ->
      @selected_training_id = parseInt training.id

  computed:
    loading: ->
      !@trainings

    trainings_as_options: ->
      return [] unless @trainings
      { key: training.id, value: training.id, text: training.name } for training in @trainings

  watch:
    selected_training_id: ->
      selected_training_id = parseInt @selected_training_id

      unless isNaN selected_training_id
        @$emit 'input', selected_training_id
        return

      @newTraining name: @selected_training_id

    training_id:
      immediate: true
      handler: ->
        return unless @training_id
        @selected_training_id = parseInt @training_id

</script>
