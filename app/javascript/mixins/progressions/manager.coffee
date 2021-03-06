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
    add_new: 'before'

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
      @progressions_resource ?= new ProgressionsResource

      if @parent_progressions
        @progressionsLoaded progressions: @parent_progressions
        return

      @progressions_resource.index @progressionsLoaded, @context

    progressionsLoaded: (response) ->
      @progressions = response.progressions

    buildProgression: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      new Progression final_params

    newProgression: (params = {}) ->
      @setFormProgression @buildProgression params

    setFormProgression: (@form_progression) ->
      @form_progression

    clearFormProgression: ->
      @setFormProgression null

    progressionIndex: (progression_id) ->
      for index, progression of @progressions
        return index if progression.id == progression_id

      -1

    saveProgression: (progression, custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @progressionSaved(data)
          custom_callback(data)

        @progressions_resource.save progression, callback
        return

      @progressions_resource.save progression, @progressionSaved

    saveFormProgression: (custom_callback = false) ->
      @saveProgression @form_progression, custom_callback

    createProgression: (attributes, custom_callback = false) ->
      @saveProgression @buildProgression(attributes), custom_callback

    addProgression: (progression) ->
      index = @progressionIndex progression.id

      if index == -1
        if @add_new == 'before'
          @progressions.unshift progression
          index = 0
        else
          @progressions.push progression
          index = @progressions.length - 1

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

  watch:
    context:
      immediate: true
      handler: ->
        @loadProgressions()
