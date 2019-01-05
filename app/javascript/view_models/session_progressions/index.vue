<template lang="pug">
.entity-index.session_progressions-index.default-container
  session_progressions-list(:session_progressions='session_progressions')
</template>

<script lang="coffee">
import SessionProgressionsResource from '../../resources/session_progressions_resource'

export default
  data: ->
    session_progressions: null

  methods:
    loadSessionProgressions: ->
      @session_progressions_resource.index @session_progressionsLoaded

    session_progressionsLoaded: (response) ->
      @session_progressions = response.session_progressions

  mounted: ->
    @session_progressions_resource = new SessionProgressionsResource
    @loadSessionProgressions()
</script>
