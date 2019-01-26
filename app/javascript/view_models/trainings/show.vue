<template lang="pug">
.entity-show-wrapper.trainings-show-wrapper.default-container
  .entity-show.trainings-show(v-if='training')
    h1.entity-show-header
      | {{ training.name }}

  sessions-list(:sessions='training.sessions')
</template>

<script lang="coffee">
import TrainingsResource from '../../resources/trainings_resource'

export default
  data: ->
    training: null
    training_id: null

  methods:
    loadTraining: ->
      @trainings_resource.get @training_id, @trainingLoaded

    trainingLoaded: (response) ->
      @training = response.training

  mounted: ->
    @trainings_resource = new TrainingsResource
    @training_id = @$route.params.id
    @loadTraining()
</script>
