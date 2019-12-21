<template lang="pug">
  sui-dropdown(:options='session_progressions_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               placeholder='Session Progression'
               v-model='selected_session_progression_id')
</template>

<script lang="coffee">
import SessionProgressionsResource from '../../resources/session_progressions_resource'

export default
  model:
    prop: 'session_progression_id'

  props:
    session_progression_id: null

  data: ->
    session_progressions: null
    selected_session_progression_id: null

  methods:
    loadSessionProgressions: ->
      @session_progressions_resource.index @sessionProgressionsLoaded

    sessionProgressionsLoaded: (response) ->
      @session_progressions = response.session_progressions

    sessionProgressionIndex: (session_progression_id) ->
      for index, session_progression of @session_progressions
        return index if session_progression.id == session_progression_id

      -1

    getSessionProgression: (session_progression_id) ->
      index = @sessionProgressionIndex session_progression_id
      return null if index == -1
      @session_progressions[index]

  computed:
    loading: ->
      !@session_progressions

    session_progressions_as_options: ->
      return [] unless @session_progressions
      { key: session_progression.id, value: session_progression.id, text: session_progression.name } for session_progression in @session_progressions

  watch:
    selected_session_progression_id: ->
      @$emit 'input', @selected_session_progression_id

    session_progression_id:
      immediate: true
      handler: ->
        return unless @session_progression_id
        @selected_session_progression_id = parseInt @session_progression_id

  mounted: ->
    @session_progressions_resource = new SessionProgressionsResource
    @loadSessionProgressions()

</script>
