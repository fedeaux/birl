<template lang="pug">
.entity-new.training-new.default-container
  .entity-display
    .entity-display-main New Training

  trainings-form(v-model='training'
                 @save='saveTraining'
                 @cancel='back')
</template>

<script lang="coffee">

import TrainingsResource from '../../resources/trainings_resource'
import Training from '../../models/training'

export default
  data: ->
    training: new Training

  methods:
    saveTraining: ->
      @trainings_resource.save @training, @saved

    saved: (data) ->
      @$router.push data.training.path()

    back: ->
      @$router.push @training.collectionPath()

  mounted: ->
    @trainings_resource = new TrainingsResource
</script>
