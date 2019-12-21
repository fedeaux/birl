<template lang="pug">
.entity-show-wrapper.exercises-show-wrapper.default-container(v-if='exercise')
  .entity-show.exercises-show
    exercises-display(:exercise='exercise')
      router-link.entity-show-header-actions(:to='exercise.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  progressions-manager(v-if='exercise_id' :context='{ exercise_id: exercise_id }' :allow_actions='true')
  //- BrainDamage: Body End
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

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @exercise = @parent_exercise if @parent_exercise
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    '$route.params.id':
      immediate: true
      handler: ->
        @exercises_resource ?= new ExercisesResource
        @exercise_id = parseInt @$route.params.id
        @loadExercise()
</script>
