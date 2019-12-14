<template lang="pug">
.entity-manager.exercises-manager.default-container
  .entity-manager-form(v-if='form_exercise')
    exercises-form(v-model='form_exercise'
                   @save='saveFormExercise()'
                   @cancel='clearFormExercise()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-exercise-button.ui.primary.top.attached.fluid.small.icon.button(@click='newExercise')
        i.plus.icon
        |  Add

    exercises-list(:exercises='exercises'
                   :allow_actions='true'
                   @edit='editExercise($event)'
                   @destroy='destroyExercise($event)')
</template>

<script lang="coffee">
import ExercisesResource from '../../resources/exercises_resource'
import Exercise from '../../models/exercise'

export default
  props:
    context:
      default: -> {}

    parent_exercises: null

  data: ->
    exercises: null
    form_exercise: null

  methods:
    editExercise: (data) ->
      @setFormExercise data.exercise

    destroyExercise: (data) ->
      @exercises_resource.destroy data.exercise, @exerciseRemoved

    loadExercises: ->
      @exercises_resource.index @exercisesLoaded, @context

    exercisesLoaded: (response) ->
      @exercises = response.exercises

    newExercise: ->
      @setFormExercise new Exercise @context

    setFormExercise: (@form_exercise) ->

    clearFormExercise: ->
      @setFormExercise null

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
      @clearFormExercise()

    exerciseRemoved: (data) ->
      index = @exerciseIndex data.exercise.id
      return if index == -1
      @exercises.splice index, 1

  mounted: ->
    @exercises_resource = new ExercisesResource

    if @parent_exercises
      @exercises = @parent_exercises
      return

    @loadExercises()
</script>
