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
    add_new: 'before'

  methods:
    exerciseAdded: (index, exercise) ->
      # console.log 'exerciseAdded', index, exercise

    getExercise: (exercise_id) ->
      index = @exerciseIndex exercise_id
      return null if index == -1
      @exercises[index]

    editExercise: (data) ->
      @setFormExercise data.exercise

    destroyExercise: (data) ->
      @exercises_resource.destroy data.exercise, @exerciseRemoved

    loadExercises: ->
      @exercises_resource ?= new ExercisesResource

      if @parent_exercises
        @exercisesLoaded exercises: @parent_exercises
        return

      @exercises_resource.index @exercisesLoaded, @context

    exercisesLoaded: (response) ->
      @exercises = response.exercises

    buildExercise: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      new Exercise final_params

    newExercise: (params = {}) ->
      @setFormExercise @buildExercise params

    setFormExercise: (@form_exercise) ->
      @form_exercise

    clearFormExercise: ->
      @setFormExercise null

    exerciseIndex: (exercise_id) ->
      for index, exercise of @exercises
        return index if exercise.id == exercise_id

      -1

    saveExercise: (exercise, custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @exerciseSaved(data)
          custom_callback(data)

        @exercises_resource.save exercise, callback
        return

      @exercises_resource.save exercise, @exerciseSaved

    saveFormExercise: (custom_callback = false) ->
      @saveExercise @form_exercise, custom_callback

    createExercise: (attributes, custom_callback = false) ->
      @saveExercise @buildExercise(attributes), custom_callback

    addExercise: (exercise) ->
      index = @exerciseIndex exercise.id

      if index == -1
        if @add_new == 'before'
          @exercises.unshift exercise
          index = 0
        else
          @exercises.push exercise
          index = @exercises.length - 1

      else
        Vue.set @exercises, index, exercise

      @exerciseAdded index, exercise

    exerciseSaved: (data) ->
      @addExercise data.exercise
      @clearFormExercise()

    exerciseRemoved: (data) ->
      index = @exerciseIndex data.exercise.id
      return if index == -1
      @exercises.splice index, 1

  watch:
    context:
      immediate: true
      handler: ->
        @loadExercises()
