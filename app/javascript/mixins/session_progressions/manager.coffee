import SessionProgressionsResource from '../../resources/session_progressions_resource'
import SessionProgression from '../../models/session_progression'

export default
  props:
    context:
      default: -> {}

    parent_session_progressions: null

  data: ->
    session_progressions: null
    form_session_progression: null

  methods:
    sessionProgressionAdded: (index, sessionProgression) ->
      # console.log 'sessionProgressionAdded', index, sessionProgression

    getSessionProgression: (session_progression_id) ->
      index = @sessionProgressionIndex sessionProgression_id
      return null if index == -1
      @session_progressions[index]

    editSessionProgression: (data) ->
      @setFormSessionProgression data.session_progression

    destroySessionProgression: (data) ->
      @session_progressions_resource.destroy data.session_progression, @sessionProgressionRemoved

    loadSessionProgressions: ->
      @session_progressions_resource.index @sessionProgressionsLoaded, @context

    sessionProgressionsLoaded: (response) ->
      @session_progressions = response.session_progressions

    newSessionProgression: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      @setFormSessionProgression new SessionProgression final_params

    setFormSessionProgression: (@form_session_progression) ->
      @form_session_progression

    clearFormSessionProgression: ->
      @setFormSessionProgression null

    sessionProgressionIndex: (session_progression_id) ->
      for index, session_progression of @session_progressions
        return index if session_progression.id == session_progression_id

      -1

    saveFormSessionProgression: (custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @sessionProgressionSaved(data)
          custom_callback(data)

        @session_progressions_resource.save @form_session_progression, callback
        return

      @session_progressions_resource.save @form_session_progression, @sessionProgressionSaved

    addSessionProgression: (session_progression) ->
      index = @sessionProgressionIndex session_progression.id

      if index == -1
        @session_progressions.unshift session_progression
        index = 0

      else
        Vue.set @session_progressions, index, session_progression

      @sessionProgressionAdded index, session_progression

    sessionProgressionSaved: (data) ->
      @addSessionProgression data.session_progression
      @clearFormSessionProgression()

    sessionProgressionRemoved: (data) ->
      index = @sessionProgressionIndex data.session_progression.id
      return if index == -1
      @session_progressions.splice index, 1

  mounted: ->
    @session_progressions_resource = new SessionProgressionsResource

    if @parent_session_progressions
      @session_progressions = @parent_session_progressions
      return

    unless @context
      @loadSessionProgressions()

  watch:
    context:
      immediate: true
      handler: ->
        @session_progressions_resource ?= new SessionProgressionsResource
        @loadSessionProgressions()
