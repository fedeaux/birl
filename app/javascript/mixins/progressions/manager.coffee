import ProgressionsResource from '../../resources/progressions_resource'
import Progression from '../../models/progression'

export default
  props:
    context:
      default: -> {}

    parent_progressions: null

  data: ->
    progressions: null
    form_progression: null

  methods:
    progressionAdded: (index, progression) ->
      # console.log 'progressionAdded', index, progression

    getProgression: (progression_id) ->
      index = @progressionIndex progression_id
      return null if index == -1
      @progressions[index]

    editProgression: (data) ->
      @setFormProgression data.progression

    destroyProgression: (data) ->
      @progressions_resource.destroy data.progression, @progressionRemoved

    loadProgressions: ->
      @progressions_resource.index @progressionsLoaded, @context

    progressionsLoaded: (response) ->
      @progressions = response.progressions

    newProgression: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      @setFormProgression new Progression final_params

    setFormProgression: (@form_progression) ->

    clearFormProgression: ->
      @setFormProgression null

    progressionIndex: (progression_id) ->
      for index, progression of @progressions
        return index if progression.id == progression_id

      -1

    saveFormProgression: (custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @progressionSaved(data)
          custom_callback(data)

        @progressions_resource.save @form_progression, callback
        return

      @progressions_resource.save @form_progression, @progressionSaved

    addProgression: (progression) ->
      index = @progressionIndex progression.id

      if index == -1
        @progressions.unshift progression
        index = 0

      else
        Vue.set @progressions, index, progression

      @progressionAdded index, progression

    progressionSaved: (data) ->
      @addProgression data.progression
      @clearFormProgression()

    progressionRemoved: (data) ->
      index = @progressionIndex data.progression.id
      return if index == -1
      @progressions.splice index, 1

  mounted: ->
    @progressions_resource = new ProgressionsResource

    if @parent_progressions
      @progressions = @parent_progressions
      return

    unless @context
      @loadProgressions()

  watch:
    context:
      immediate: true
      handler: ->
        @progressions_resource ?= new ProgressionsResource
        @loadProgressions()
