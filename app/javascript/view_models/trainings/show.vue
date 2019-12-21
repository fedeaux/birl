<template lang="pug">
.entity-show-wrapper.trainings-show-wrapper.default-container(v-if='training')
  .entity-show.trainings-show
    trainings-display(:training='training')
      router-link.entity-show-header-actions(:to='training.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import TrainingsResource from '../../resources/trainings_resource'

export default
  props:
    parent_training: null

  data: ->
    training: null
    training_id: null

  methods:
    loadTraining: ->
      @trainings_resource.get @training_id, @trainingLoaded

    trainingLoaded: (response) ->
      @training = response.training

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @training = @parent_training if @parent_training
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    '$route.params.id':
      immediate: true
      handler: ->
        @trainings_resource ?= new TrainingsResource
        @training_id = parseInt @$route.params.id
        @loadTraining()
</script>
