<template lang="pug">
.entity-form-wrapper.exercises-form-wrapper.default-container(v-if='exercise')
  .entity-form.exercises-form
    .ui.form
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
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  mounted: ->

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
