<template lang="pug">
.entity-edit.exercise-edit.default-container
  exercises-form(v-model='exercise'
                 v-if='exercise'
                 @save='saveExercise()'
                 @cancel='exerciseDone()')
</template>

<script lang="coffee">

import ExercisesResource from '../../resources/exercises_resource'
import Exercise from '../../models/exercise'

export default
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

  computed:
    exercise_id: ->
      @$route.params.id

  mounted: ->
    @exercises_resource = new ExercisesResource
    @loadExercise()
</script>
