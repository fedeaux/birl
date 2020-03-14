<template lang="pug">
.trainings-show-wrapper.flex-column.t-padded-2(v-if='training')
  .trainings-show.flex-item-fixed
    trainings-display(:training='training')
      shared-link.action-text(:to='training.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import TrainingsResource from '../../resources/trainings_resource'

export default
  props:
    parent_training: null
    training_id:
      default: null

  data: ->
    training: null

  methods:
    loadTraining: ->
      return unless @training_id
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
    training_id:
      immediate: true
      handler: ->
        @trainings_resource ?= new TrainingsResource
        @loadTraining()
</script>
