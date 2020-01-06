import SessionsResource from '../../resources/sessions_resource'
import Session from '../../models/session'

export default
  props:
    context:
      default: -> {}

    parent_sessions: null

  data: ->
    sessions: null
    form_session: null

  methods:
    sessionAdded: (index, session) ->
      # console.log 'sessionAdded', index, session

    getSession: (session_id) ->
      index = @sessionIndex session_id
      return null if index == -1
      @sessions[index]

    editSession: (data) ->
      @setFormSession data.session

    destroySession: (data) ->
      @sessions_resource.destroy data.session, @sessionRemoved

    loadSessions: ->
      @sessions_resource ?= new SessionsResource

      if @parent_sessions
        @sessionsLoaded sessions: @parent_sessions
        return

      @sessions_resource.index @sessionsLoaded, @context

    sessionsLoaded: (response) ->
      @sessions = response.sessions

    newSession: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      @setFormSession new Session final_params

    setFormSession: (@form_session) ->
      @form_session

    clearFormSession: ->
      @setFormSession null

    sessionIndex: (session_id) ->
      for index, session of @sessions
        return index if session.id == session_id

      -1

    saveFormSession: (custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @sessionSaved(data)
          custom_callback(data)

        @sessions_resource.save @form_session, callback
        return

      @sessions_resource.save @form_session, @sessionSaved

    addSession: (session) ->
      index = @sessionIndex session.id

      if index == -1
        @sessions.unshift session
        index = 0

      else
        Vue.set @sessions, index, session

      @sessionAdded index, session

    sessionSaved: (data) ->
      @addSession data.session
      @clearFormSession()

    sessionRemoved: (data) ->
      index = @sessionIndex data.session.id
      return if index == -1
      @sessions.splice index, 1

  watch:
    context:
      immediate: true
      handler: ->
        @loadSessions()
