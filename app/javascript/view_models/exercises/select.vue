<template lang="pug">
  sui-dropdown(:options='exercises_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               placeholder='Exercise'
               v-model='selected_exercise_id')
</template>

<script lang="coffee">
import ExercisesResource from '../../resources/exercises_resource'

export default
  model:
    prop: 'exercise_id'

  props:
    exercise_id: null

  data: ->
    exercises: null
    selected_exercise_id: null

  methods:
    loadExercises: ->
      @exercises_resource.index @exercisesLoaded

    exercisesLoaded: (response) ->
      @exercises = response.exercises

    exerciseIndex: (exercise_id) ->
      for index, exercise of @exercises
        return index if exercise.id == exercise_id

      -1

    getExercise: (exercise_id) ->
      index = @exerciseIndex exercise_id
      return null if index == -1
      @exercises[index]

  computed:
    loading: ->
      !@exercises

    exercises_as_options: ->
      return [] unless @exercises
      { key: exercise.id, value: exercise.id, text: exercise.name } for exercise in @exercises

  watch:
    selected_exercise_id: ->
      @$emit 'input', @selected_exercise_id

    exercise_id:
      immediate: true
      handler: ->
        return unless @exercise_id
        @selected_exercise_id = parseInt @exercise_id

  mounted: ->
    @exercises_resource = new ExercisesResource
    @loadExercises()

</script>
