<template lang="pug">
  shared-modal(v-if='form_session_progression' title='New Session Progression')
    session-progressions-form(v-model='form_session_progression'
                   @save='saveFormSessionProgression()'
                   @cancel='clearFormSessionProgression()')

  sui-dropdown(:options='session_progressions_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Session Progression'
               v-else
               v-model='selected_session_progression_id')

</template>

<script lang="coffee">
import SessionProgressionsManagerMixin from '../../mixins/session_progressions/manager'

export default
  mixins: [SessionProgressionsManagerMixin]

  model:
    prop: 'session_progression_id'

  props:
    session_progression_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_session_progression_id: null

  methods:
    sessionProgressionAdded: (index, sessionProgression) ->
      @selectSessionProgression session_progression

    selectSessionProgression: (session_progression) ->
      @selected_session_progression_id = parseInt session_progression.id

  computed:
    loading: ->
      !@session_progressions

    session_progressions_as_options: ->
      return [] unless @session_progressions
      { key: session_progression.id, value: session_progression.id, text: session_progression.name } for session_progression in @session_progressions

  watch:
    selected_session_progression_id: ->
      selected_session_progression_id = parseInt @selected_session_progression_id

      unless isNaN selected_session_progression_id
        @$emit 'input', selected_session_progression_id
        return

      @newSessionProgression name: @selected_session_progression_id

    session_progression_id:
      immediate: true
      handler: ->
        return unless @session_progression_id
        @selected_session_progression_id = parseInt @session_progression_id

</script>
