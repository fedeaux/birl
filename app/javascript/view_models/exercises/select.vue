<template lang="pug">
  shared-modal(v-if='form_exercise' title='New Exercise')
    exercises-form(v-model='form_exercise'
                   @save='saveFormExercise()'
                   @cancel='clearFormExercise()')

  sui-dropdown(:options='exercises_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Exercise'
               v-else
               v-model='selected_exercise_id')

</template>

<script lang="coffee">
import ExercisesManagerMixin from '../../mixins/exercises/manager'

export default
  mixins: [ExercisesManagerMixin]

  model:
    prop: 'exercise_id'

  props:
    exercise_id: null
    allow_additions: true

  data: ->
    selected_exercise_id: null

  methods:
    exerciseAdded: (index, exercise) ->
      @selectExercise exercise

    selectExercise: (exercise) ->
      @selected_exercise_id = parseInt exercise.id

  computed:
    loading: ->
      !@exercises

    exercises_as_options: ->
      return [] unless @exercises
      { key: exercise.id, value: exercise.id, text: exercise.name } for exercise in @exercises

  watch:
    selected_exercise_id: ->
      selected_exercise_id = parseInt @selected_exercise_id

      unless isNaN selected_exercise_id
        @$emit 'input', selected_exercise_id
        return

      @newExercise name: @selected_exercise_id

    exercise_id:
      immediate: true
      handler: ->
        return unless @exercise_id
        @selected_exercise_id = parseInt @exercise_id

</script>
