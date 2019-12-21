<template lang="pug">
.entity-manager.session-progressions-manager.default-container
  .entity-manager-form(v-if='form_session_progression')
    session-progressions-form(v-model='form_session_progression'
                              @save='saveFormSessionProgression()'
                              @cancel='clearFormSessionProgression()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-session-progression-button.ui.primary.top.attached.fluid.small.icon.button(@click='newSessionProgression')
        i.plus.icon
        |  Add

    session-progressions-list(:session_progressions='session_progressions'
                              :allow_actions='true'
                              @edit='editSessionProgression($event)'
                              @destroy='destroySessionProgression($event)')
</template>

<script lang="coffee">
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
    editSessionProgression: (data) ->
      @setFormSessionProgression data.session_progression

    destroySessionProgression: (data) ->
      @session_progressions_resource.destroy data.session_progression, @sessionProgressionRemoved

    loadSessionProgressions: ->
      @session_progressions_resource.index @sessionProgressionsLoaded, @context

    sessionProgressionsLoaded: (response) ->
      @session_progressions = response.session_progressions

    newSessionProgression: ->
      @setFormSessionProgression new SessionProgression @context

    setFormSessionProgression: (@form_session_progression) ->

    clearFormSessionProgression: ->
      @setFormSessionProgression null

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

    @loadSessionProgressions()
</script>
