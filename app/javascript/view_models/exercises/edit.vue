<template lang="pug">
.entity-edit.exercise-edit.default-container
  .entity-display
    .entity-display-main Edit Exercise

  exercises-form(v-model='exercise'
                 v-if='exercise'
                 @save='saveExercise()'
                 @cancel='exerciseDone()')
</template>

<script lang="coffee">

import ExercisesResource from '../../resources/exercises_resource'
import Exercise from '../../models/exercise'

export default
  props:
    exercise_id:
      default: null

  data: ->
    exercise: null

  methods:
    loadExercise: ->
      @exercises_resource.get @exercise_id, @exerciseLoaded

    exerciseLoaded: (response) ->
      @exercise = response.exercise

    saveExercise: ->
      @exercises_resource.save @exercise, @exerciseDone

    exerciseDone: ->
      @$router.push @exercise.path()

  mounted: ->
    @exercises_resource = new ExercisesResource
    @loadExercise()
</script>
