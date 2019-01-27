<template lang="pug">
  sui-dropdown(:options='exercises_as_options' :loading='loading' placeholder='Exercise' v-model='selected_exercise_id')
</template>

<script lang="coffee">
import ExercisesResource from '../../resources/exercises_resource'

export default
  props:
    value: null

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
      @$emit 'input', @getExercise @selected_exercise_id

    value:
      immediate: true
      handler: ->
        return unless @value and @value.id
        @selected_exercise_id = @value.id

  mounted: ->
    @exercises_resource = new ExercisesResource
    @loadExercises()

</script>
