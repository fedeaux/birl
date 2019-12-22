<template lang="pug">
.entity-manager.trainings-manager.default-container
  .entity-manager-form(v-if='form_training')
    trainings-form(v-model='form_training'
                   @save='saveFormTraining()'
                   @cancel='clearFormTraining()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-training-button.ui.primary.top.attached.fluid.small.icon.button(@click='newTraining')
        i.plus.icon
        |  Add Training

    trainings-list(:trainings='trainings'
                   :allow_actions='true'
                   @edit='editTraining($event)'
                   @destroy='destroyTraining($event)')
</template>

<script lang="coffee">
import TrainingsResource from '../../resources/trainings_resource'
import Training from '../../models/training'

export default
  props:
    context:
      default: -> {}

    parent_trainings: null

  data: ->
    trainings: null
    form_training: null

  methods:
    editTraining: (data) ->
      @setFormTraining data.training

    destroyTraining: (data) ->
      @trainings_resource.destroy data.training, @trainingRemoved

    loadTrainings: ->
      @trainings_resource.index @trainingsLoaded, @context

    trainingsLoaded: (response) ->
      @trainings = response.trainings

    newTraining: ->
      @setFormTraining new Training @context

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
      @clearFormTraining()

    trainingRemoved: (data) ->
      index = @trainingIndex data.training.id
      return if index == -1
      @trainings.splice index, 1

  mounted: ->
    @trainings_resource = new TrainingsResource

    if @parent_trainings
      @trainings = @parent_trainings
      return

    @loadTrainings()
</script>
