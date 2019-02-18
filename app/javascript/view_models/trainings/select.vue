<template lang="pug">
  sui-dropdown(:options='trainings_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               placeholder='Training'
               v-model='selected_training_id')
</template>

<script lang="coffee">
import TrainingsResource from '../../resources/trainings_resource'

export default
  model:
    prop: 'training_id'

  props:
    training_id: null

  data: ->
    trainings: null
    selected_training_id: null

  methods:
    loadTrainings: ->
      @trainings_resource.index @trainingsLoaded

    trainingsLoaded: (response) ->
      @trainings = response.trainings

    trainingIndex: (training_id) ->
      for index, training of @trainings
        return index if training.id == training_id

      -1

    getTraining: (training_id) ->
      index = @trainingIndex training_id
      return null if index == -1
      @trainings[index]

  computed:
    loading: ->
      !@trainings

    trainings_as_options: ->
      return [] unless @trainings
      { key: training.id, value: training.id, text: training.name } for training in @trainings

  watch:
    selected_training_id: ->
      @$emit 'input', @selected_training_id

    training_id:
      immediate: true
      handler: ->
        return unless @training_id
        @selected_training_id = parseInt @training_id

  mounted: ->
    @trainings_resource = new TrainingsResource
    @loadTrainings()

</script>
