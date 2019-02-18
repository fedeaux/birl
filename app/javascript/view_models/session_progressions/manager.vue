<template lang="pug">
.entity-manager.session_progressions-manager.default-container
  .entity-manager-form(v-if='form_session_progression')
    session_progressions-form(v-model='form_session_progression' @save='saveFormSessionProgression()')

  .entity-manager-list(v-else)
    #new-session_progression-button.ui.primary.small.icon.button(@click='newSessionProgression')
      i.add.icon
      | add
    session_progressions-list(:session_progressions='session_progressions')
</template>

<script lang="coffee">
import SessionProgressionsResource from '../../resources/session_progressions_resource'
import SessionProgression from '../../models/session_progression'

export default
  props:
    context:
      default: -> {}

  data: ->
    session_progressions: null
    form_session_progression: null

  methods:
    loadSessionProgressions: ->
      @session_progressions_resource.index @session_progressionsLoaded, @context

    sessionProgressionsLoaded: (response) ->
      @session_progressions = response.session_progressions

    newSessionProgression: ->
      @setFormSessionProgression new SessionProgression(@context)

    setFormSessionProgression: (@form_session_progression) ->

    sessionProgressionIndex: (session_progression_id) ->
      for index, session_progression of @session_progressions
        return index if session_progression.id == session_progression_id

      -1

    saveFormSessionProgression: ->
      @session_progressions_resource.save @form_session_progression, @sessionProgressionSaved

    addSessionProgression: (session_progression) ->
      index = @sessionProgressionIndex session_progression.id

      if index == -1
        @session_progressions.push session_progression
        return

      Vue.set @session_progressions, index, session_progression

    sessionProgressionSaved: (data) ->
      @addSessionProgression data.session_progression

  mounted: ->
    @session_progressions_resource = new SessionProgressionsResource
    @loadSessionProgressions()
</script>
