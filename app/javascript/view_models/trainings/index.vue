<template lang="pug">
.entity-index.trainings-index.default-container
  trainings-manager(:parent_trainings='trainings')
</template>

<script lang="coffee">
import TrainingsResource from '../../resources/trainings_resource'

export default
  data: ->
    trainings: null

  methods:
    loadTrainings: ->
      @trainings_resource.index @trainingsLoaded

    trainingsLoaded: (response) ->
      @trainings = response.trainings

  mounted: ->
    @trainings_resource = new TrainingsResource
    @loadTrainings()
</script>
