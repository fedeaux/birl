<template lang="pug">
.entity-index.session-progressions-index.default-container
  session-progressions-manager(:session_progressions='session_progressions')
</template>

<script lang="coffee">
import SessionProgressionsResource from '../../resources/session_progressions_resource'

export default
  data: ->
    session_progressions: null

  methods:
    loadSessionProgressions: ->
      @session_progressions_resource.index @sessionProgressionsLoaded

    sessionProgressionsLoaded: (response) ->
      @session_progressions = response.session_progressions

  mounted: ->
    @session_progressions_resource = new SessionProgressionsResource
    @loadSessionProgressions()
</script>
