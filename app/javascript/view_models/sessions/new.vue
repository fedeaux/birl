<template lang="pug">
.entity-new.session-new.default-container
  .entity-display
    .entity-display-main New Session

  sessions-form(v-model='session'
                @save='saveSession'
                @cancel='back')
</template>

<script lang="coffee">

import SessionsResource from '../../resources/sessions_resource'
import Session from '../../models/session'

export default
  data: ->
    session: new Session

  methods:
    saveSession: ->
      @sessions_resource.save @session, @saved

    saved: (data) ->
      @$router.push data.session.path()

    back: ->
      @$router.push @session.collectionPath()

  mounted: ->
    @sessions_resource = new SessionsResource
</script>
