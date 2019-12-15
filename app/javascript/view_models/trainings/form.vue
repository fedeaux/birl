<template lang="pug">
.entity-form-wrapper.trainings-form-wrapper.default-container(v-if='training')
  .entity-form.trainings-form
    .ui.form
      .field
        label Name
        input(type='text' v-model='training.name')

      .field
        label Context
        contexts-select(v-model='training.context_id')

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import TrainingsResource from '../../resources/trainings_resource'
import Training from '../../models/training'

export default
  model:
    prop: 'original_training'

  props:
    original_training: null

  data: ->
    training: null

  methods:
    save: ->
      @$emit 'input', @training
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_training:
      immediate: true
      deep: true
      handler: ->
        if @original_training
          @training = @original_training.clone()
        else
          @training = null
</script>
