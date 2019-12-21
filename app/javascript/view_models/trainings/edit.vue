<template lang="pug">
.entity-edit.training-edit.default-container
  .entity-display
    .entity-display-main Edit Training

  trainings-form(v-model='training'
                 v-if='training'
                 @save='saveTraining()'
                 @cancel='trainingDone()')
</template>

<script lang="coffee">

import TrainingsResource from '../../resources/trainings_resource'
import Training from '../../models/training'

export default
  data: ->
    training: null

  methods:
    loadTraining: ->
      @trainings_resource.get @training_id, @trainingLoaded

    trainingLoaded: (response) ->
      @training = response.training

    saveTraining: ->
      @trainings_resource.save @training, @trainingDone

    trainingDone: ->
      @$router.push @training.path()

  computed:
    training_id: ->
      @$route.params.id

  mounted: ->
    @trainings_resource = new TrainingsResource
    @loadTraining()
</script>
