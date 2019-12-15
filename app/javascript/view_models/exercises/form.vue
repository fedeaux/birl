<template lang="pug">
.entity-form-wrapper.exercises-form-wrapper.default-container(v-if='exercise')
  .entity-form.exercises-form
    .ui.form
      .field
        label Name
        input(type='text' v-model='exercise.name')

      .field
        label Slug
        input(type='text' v-model='exercise.slug')

      .field
        label Progression Type
        input(type='text' v-model='exercise.progression_type')

      .field
        label Context
        contexts-select(v-model='exercise.context_id')

      .field
        label Group
        groups-select(v-model='exercise.group_id')

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import ExercisesResource from '../../resources/exercises_resource'
import Exercise from '../../models/exercise'

export default
  model:
    prop: 'original_exercise'

  props:
    original_exercise: null

  data: ->
    exercise: null

  methods:
    save: ->
      @$emit 'input', @exercise
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_exercise:
      immediate: true
      deep: true
      handler: ->
        if @original_exercise
          @exercise = @original_exercise.clone()
        else
          @exercise = null
</script>
