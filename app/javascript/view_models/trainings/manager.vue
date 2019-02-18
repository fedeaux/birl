<template lang="pug">
.entity-manager.trainings-manager.default-container
  .entity-manager-form(v-if='form_training')
    trainings-form(v-model='form_training'
                   @save='saveFormTraining()'
                   @cancel='clearFormTraining()')

  .entity-manager-list(v-else)
    #new-training-button.ui.primary.top.attached.fluid.small.icon.button(@click='newTraining')
      | Add

    trainings-list(:trainings='trainings')
</template>

<script lang="coffee">
import TrainingsResource from '../../resources/trainings_resource'
import Training from '../../models/training'

export default
  props:
    context:
      default: -> {}

  data: ->
    trainings: null
    form_training: null

  methods:
    loadTrainings: ->
      @trainings_resource.index @trainingsLoaded, @context

    trainingsLoaded: (response) ->
      @trainings = response.trainings

    newTraining: ->
      @setFormTraining new Training(@context)

    setFormTraining: (@form_training) ->

    clearFormTraining: ->
      @setFormTraining null

    trainingIndex: (training_id) ->
      for index, training of @trainings
        return index if training.id == training_id

      -1

    saveFormTraining: ->
      @trainings_resource.save @form_training, @trainingSaved

    addTraining: (training) ->
      index = @trainingIndex training.id

      if index == -1
        @trainings.push training
        return

      Vue.set @trainings, index, training

    trainingSaved: (data) ->
      @addTraining data.training

  mounted: ->
    @trainings_resource = new TrainingsResource
    @loadTrainings()
</script>
