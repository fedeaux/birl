<template lang="pug">
.entity-show-wrapper.exercises-show-wrapper.default-container(v-if='exercise')
  .header-contents-footer
    .entity-show.exercises-show.header-contents-footer-header
      exercises-display(:exercise='exercise')
        shared-link.entity-show-header-actions(:to='exercise.editPath()')
          i.edit.icon

    //- BrainDamage: Body Start
    .header-contents-footer-contents
      progressions-manager(v-if='exercise_id' :context='{ exercise_id: exercise_id }' :allow_actions='true')
    //- BrainDamage: Body End
</template>

<script lang="coffee">
import ExercisesResource from '../../resources/exercises_resource'

export default
  props:
    parent_exercise: null
    exercise_id:
      default: null

  data: ->
    exercise: null

  methods:
    loadExercise: ->
      return unless @exercise_id
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
    exercise_id:
      immediate: true
      handler: ->
        @exercises_resource ?= new ExercisesResource
        @loadExercise()
</script>
