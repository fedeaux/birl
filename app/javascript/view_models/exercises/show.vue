<template lang="pug">
.entity-show-wrapper.exercises-show-wrapper.default-container.with-footer
  .entity-show.exercises-show(v-if='exercise')
    h1.entity-show-header
      | {{ exercise.name }}

  progressions-manager(v-if='exercise_id' :context='{ exercise_id: exercise_id }' :allow_actions='true')

  shared-footer(v-if='exercise')
    router-link.ui.fluid.red.basic.button(:to='exercise.editPath()')
      | Edit
</template>

<script lang="coffee">
import ExercisesResource from '../../resources/exercises_resource'

export default
  data: ->
    exercise: null
    exercise_id: null

  methods:
    loadExercise: ->
      @exercises_resource.get @exercise_id, @exerciseLoaded

    exerciseLoaded: (response) ->
      @exercise = response.exercise

  mounted: ->
    @exercises_resource = new ExercisesResource
    @exercise_id = @$route.params.id
    @loadExercise()
</script>
