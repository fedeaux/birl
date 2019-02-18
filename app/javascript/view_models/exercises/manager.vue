<template lang="pug">
.entity-manager.exercises-manager.default-container
  .entity-manager-form(v-if='form_exercise')
    exercises-form(v-model='form_exercise' @save='saveFormExercise()')

  .entity-manager-list(v-else)
    #new-exercise-button.ui.primary.small.icon.button(@click='newExercise')
      i.add.icon
      | add
    exercises-list(:exercises='exercises')
</template>

<script lang="coffee">
import ExercisesResource from '../../resources/exercises_resource'
import Exercise from '../../models/exercise'

export default
  props:
    context:
      default: -> {}

  data: ->
    exercises: null
    form_exercise: null

  methods:
    loadExercises: ->
      @exercises_resource.index @exercisesLoaded, @context

    exercisesLoaded: (response) ->
      @exercises = response.exercises
      @$nextTick ->
        $('#new-exercise-button').click()

    newExercise: ->
      @setFormExercise new Exercise(@context)

    setFormExercise: (@form_exercise) ->

    exerciseIndex: (exercise_id) ->
      for index, exercise of @exercises
        return index if exercise.id == exercise_id

      -1

    saveFormExercise: ->
      @exercises_resource.save @form_exercise, @exerciseSaved

    addExercise: (exercise) ->
      index = @exerciseIndex exercise.id

      if index == -1
        @exercises.push exercise
        return

      Vue.set @exercises, index, exercise

    exerciseSaved: (data) ->
      @addExercise data.exercise

  mounted: ->
    @exercises_resource = new ExercisesResource
    @loadExercises()
</script>
