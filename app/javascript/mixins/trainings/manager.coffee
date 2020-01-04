import TrainingsResource from '../../resources/trainings_resource'
import Training from '../../models/training'

export default
  props:
    context:
      default: -> {}

    parent_trainings: null

  data: ->
    trainings: null
    form_training: null

  methods:
    trainingAdded: (index, training) ->
      # console.log 'trainingAdded', index, training

    getTraining: (training_id) ->
      index = @trainingIndex training_id
      return null if index == -1
      @trainings[index]

    editTraining: (data) ->
      @setFormTraining data.training

    destroyTraining: (data) ->
      @trainings_resource.destroy data.training, @trainingRemoved

    loadTrainings: ->
      @trainings_resource.index @trainingsLoaded, @context

    trainingsLoaded: (response) ->
      @trainings = response.trainings

    newTraining: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      @setFormTraining new Training final_params

    setFormTraining: (@form_training) ->
      @form_training

    clearFormTraining: ->
      @setFormTraining null

    trainingIndex: (training_id) ->
      for index, training of @trainings
        return index if training.id == training_id

      -1

    saveFormTraining: (custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @trainingSaved(data)
          custom_callback(data)

        @trainings_resource.save @form_training, callback
        return

      @trainings_resource.save @form_training, @trainingSaved

    addTraining: (training) ->
      index = @trainingIndex training.id

      if index == -1
        @trainings.unshift training
        index = 0

      else
        Vue.set @trainings, index, training

      @trainingAdded index, training

    trainingSaved: (data) ->
      @addTraining data.training
      @clearFormTraining()

    trainingRemoved: (data) ->
      index = @trainingIndex data.training.id
      return if index == -1
      @trainings.splice index, 1

  mounted: ->
    @trainings_resource = new TrainingsResource

    if @parent_trainings
      @trainings = @parent_trainings
      return

    unless @context
      @loadTrainings()

  watch:
    context:
      immediate: true
      handler: ->
        @trainings_resource ?= new TrainingsResource
        @loadTrainings()
