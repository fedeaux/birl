<template lang="pug">
.entity-index.exercises-index.default-container
  exercises-list(:exercises='exercises')
</template>

<script lang="coffee">
import ExercisesResource from '../../resources/exercises_resource'

export default
  data: ->
    exercises: null

  methods:
    loadExercises: ->
      @exercises_resource.index @exercisesLoaded

    exercisesLoaded: (response) ->
      @exercises = response.exercises

  mounted: ->
    @exercises_resource = new ExercisesResource
    @loadExercises()
</script>
