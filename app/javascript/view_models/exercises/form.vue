<template lang="pug">
</template>

<script lang="coffee">

import Exercise from '../../models/exercise'
import ExercisesResource from '../../resources/exercises_resource'

export default
  props: ['exercise_id']

  data: ->
    exercise: null
    loading: false

  methods:
    save: ->
      # @validate =>
      @loading = true
      @exercises_resource.save @exercise, @exerciseSaved

    validate: (onValid) ->
      @$validator.validateAll().then (valid) =>
        onValid() if onValid and valid

    exerciseSaved: (data) ->
      @setExercise data
      @loading = false
      @$router.push name: 'exercises-show', params: { id: @exercise.id }

    setExercise: (data) ->
      @exercise = data.exercise

    loadExercise: ->
      @loading = true
      id = @exercise_id or @exercise.id
      return unless id

      @exercises_resource.get id, (data) =>
        @setExercise data
        @loading = false

  mounted: ->
    @exercises_resource = new ExercisesResource

    if @exercise_id
      @loadExercise()
    else
      @setExercise exercise: new Exercise()
</script>
