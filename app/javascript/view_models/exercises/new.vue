<template lang="pug">
.entity-new.exercise-new.default-container
  .entity-display
    .entity-display-main New Exercise

  exercises-form(v-model='exercise'
                 @save='saveExercise'
                 @cancel='back')
</template>

<script lang="coffee">

import ExercisesResource from '../../resources/exercises_resource'
import Exercise from '../../models/exercise'

export default
  data: ->
    exercise: new Exercise

  methods:
    saveExercise: ->
      @exercises_resource.save @exercise, @saved

    saved: (data) ->
      @$router.push data.exercise.path()

    back: ->
      @$router.push @exercise.collectionPath()

  mounted: ->
    @exercises_resource = new ExercisesResource
</script>
