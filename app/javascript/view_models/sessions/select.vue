<template lang="pug">
  shared-modal(v-if='form_session' title='New Session')
    sessions-form(v-model='form_session'
                   @save='saveFormSession()'
                   @cancel='clearFormSession()')

  sui-dropdown(:options='sessions_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Session'
               v-else
               v-model='selected_session_id')

</template>

<script lang="coffee">
import SessionsManagerMixin from '../../mixins/sessions/manager'

export default
  mixins: [SessionsManagerMixin]

  model:
    prop: 'session_id'

  props:
    session_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_session_id: null

  methods:
    sessionAdded: (index, session) ->
      @selectSession session

    selectSession: (session) ->
      @selected_session_id = parseInt session.id

  computed:
    loading: ->
      !@sessions

    sessions_as_options: ->
      return [] unless @sessions
      { key: session.id, value: session.id, text: session.name } for session in @sessions

  watch:
    selected_session_id: ->
      selected_session_id = parseInt @selected_session_id

      unless isNaN selected_session_id
        @$emit 'input', selected_session_id
        return

      @newSession name: @selected_session_id

    session_id:
      immediate: true
      handler: ->
        return unless @session_id
        @selected_session_id = parseInt @session_id

</script>
