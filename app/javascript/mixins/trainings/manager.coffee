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
    add_new: 'before'

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
      @trainings_resource ?= new TrainingsResource

      if @parent_trainings
        @trainingsLoaded trainings: @parent_trainings
        return

      @trainings_resource.index @trainingsLoaded, @context

    trainingsLoaded: (response) ->
      @trainings = response.trainings

    buildTraining: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      new Training final_params

    newTraining: (params = {}) ->
      @setFormTraining @buildTraining params

    setFormTraining: (@form_training) ->
      @form_training

    clearFormTraining: ->
      @setFormTraining null

    trainingIndex: (training_id) ->
      for index, training of @trainings
        return index if training.id == training_id

      -1

    saveTraining: (training, custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @trainingSaved(data)
          custom_callback(data)

        @trainings_resource.save training, callback
        return

      @trainings_resource.save training, @trainingSaved

    saveFormTraining: (custom_callback = false) ->
      @saveTraining @form_training, custom_callback

    createTraining: (attributes, custom_callback = false) ->
      @saveTraining @buildTraining(attributes), custom_callback

    addTraining: (training) ->
      index = @trainingIndex training.id

      if index == -1
        if @add_new == 'before'
          @trainings.unshift training
          index = 0
        else
          @trainings.push training
          index = @trainings.length - 1

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

  watch:
    context:
      immediate: true
      handler: ->
        @loadTrainings()
