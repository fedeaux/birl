<template lang="pug">
  sui-dropdown(:options='sessions_as_options' :loading='loading' placeholder='Session' v-model='selected_session_id')
</template>

<script lang="coffee">
import SessionsResource from '../../resources/sessions_resource'

export default
  props:
    value: null

  data: ->
    sessions: null
    selected_session_id: null

  methods:
    loadSessions: ->
      @sessions_resource.index @sessionsLoaded

    sessionsLoaded: (response) ->
      @sessions = response.sessions

    sessionIndex: (session_id) ->
      for index, session of @sessions
        return index if session.id == session_id

      -1

    getSession: (session_id) ->
      index = @sessionIndex session_id
      return null if index == -1
      @sessions[index]

  computed:
    loading: ->
      !@sessions

    sessions_as_options: ->
      return [] unless @sessions
      { key: session.id, value: session.id, text: session.name } for session in @sessions

  watch:
    selected_session_id: ->
      @$emit 'input', @getSession @selected_session_id

    value:
      immediate: true
      handler: ->
        return unless @value and @value.id
        @selected_session_id = @value.id

  mounted: ->
    @sessions_resource = new SessionsResource
    @loadSessions()

</script>
