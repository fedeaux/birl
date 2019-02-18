<template lang="pug">
.entity-manager.sessions-manager.default-container
  .entity-manager-form(v-if='form_session')
    sessions-form(v-model='form_session' @save='saveFormSession()')

  .entity-manager-list(v-else)
    #new-session-button.ui.primary.small.icon.button(@click='newSession')
      i.add.icon
      | add
    sessions-list(:sessions='sessions')
</template>

<script lang="coffee">
import SessionsResource from '../../resources/sessions_resource'
import Session from '../../models/session'

export default
  props:
    context:
      default: -> {}

  data: ->
    sessions: null
    form_session: null

  methods:
    loadSessions: ->
      @sessions_resource.index @sessionsLoaded, @context

    sessionsLoaded: (response) ->
      @sessions = response.sessions
      @$nextTick ->
        $('#new-session-button').click()

    newSession: ->
      @setFormSession new Session(@context)

    setFormSession: (@form_session) ->

    sessionIndex: (session_id) ->
      for index, session of @sessions
        return index if session.id == session_id

      -1

    saveFormSession: ->
      @sessions_resource.save @form_session, @sessionSaved

    addSession: (session) ->
      index = @sessionIndex session.id

      if index == -1
        @sessions.push session
        return

      Vue.set @sessions, index, session

    sessionSaved: (data) ->
      @addSession data.session

  mounted: ->
    @sessions_resource = new SessionsResource
    @loadSessions()
</script>
