<template lang="pug">
session-progressions-manager.session-progressions-index(:parent_session_progressions='session_progressions')
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
