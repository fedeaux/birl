<template lang="pug">
.entity-show-wrapper.exercises-show-wrapper.default-container(v-if='exercise')
  .entity-show.exercises-show
    exercises-display(:exercise='exercise')
      router-link.entity-show-header-actions(:to='exercise.editPath()')
        i.edit.icon

    .entity-show-subheader Progressions
    progressions-manager(v-if='exercise_id' :context='{ exercise_id: exercise_id }' :allow_actions='true')
</template>

<script lang="coffee">
import ExercisesResource from '../../resources/exercises_resource'

export default
  props:
    parent_exercise: null

  data: ->
    exercise: null
    exercise_id: null

  methods:
    loadExercise: ->
      @exercises_resource.get @exercise_id, @exerciseLoaded

    exerciseLoaded: (response) ->
      @exercise = response.exercise

  mounted: ->
    if @parent_exercise
      @exercise = @parent_exercise
      return

    @exercises_resource = new ExercisesResource
    @exercise_id = @$route.params.id
    @loadExercise()
</script>
