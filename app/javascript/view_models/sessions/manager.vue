<template lang="pug">
.entity-manager.sessions-manager.default-container
  .entity-manager-form(v-if='form_session')
    sessions-form(v-model='form_session'
                  @save='saveFormSession()'
                  @cancel='clearFormSession()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-session-button.ui.primary.top.attached.fluid.small.icon.button(@click='newSession')
        i.plus.icon
        |  Add Session

    sessions-list(:sessions='sessions'
                  :allow_actions='true'
                  @edit='editSession($event)'
                  @destroy='destroySession($event)')
</template>

<script lang="coffee">
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
    editSession: (data) ->
      @setFormSession data.session

    destroySession: (data) ->
      @sessions_resource.destroy data.session, @sessionRemoved

    loadSessions: ->
      @sessions_resource.index @sessionsLoaded, @context

    sessionsLoaded: (response) ->
      @sessions = response.sessions

    newSession: ->
      @setFormSession new Session @context

    setFormSession: (@form_session) ->

    clearFormSession: ->
      @setFormSession null

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
      @clearFormSession()

    sessionRemoved: (data) ->
      index = @sessionIndex data.session.id
      return if index == -1
      @sessions.splice index, 1

  mounted: ->
    @sessions_resource = new SessionsResource

    if @parent_sessions
      @sessions = @parent_sessions
      return

    @loadSessions()
</script>
