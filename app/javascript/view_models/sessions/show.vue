<template lang="pug">
.entity-show-wrapper.sessions-show-wrapper.default-container
  .entity-show.sessions-show(v-if='session')
    h1.entity-show-header
      | {{ session.name }}
</template>

<script lang="coffee">
import SessionsResource from '../../resources/sessions_resource'

export default
  data: ->
    session: null
    session_id: null

  methods:
    loadSession: ->
      @sessions_resource.get @session_id, @sessionLoaded

    sessionLoaded: (response) ->
      @session = response.session

  mounted: ->
    @sessions_resource = new SessionsResource
    @session_id = @$route.params.id
    @loadSession()
</script>
