<template lang="pug">
.entity-show-wrapper.sessions-show-wrapper.default-container.with-footer
  .entity-show.sessions-show(v-if='session')
    h1.entity-show-header
      | {{ session.name }}

  progressions-manager(v-if='session' :parent_progressions='session.progressions')

  shared-footer(v-if='session')
    router-link.ui.fluid.red.basic.button(:to='session.editPath()')
      | Edit
</template>

<script lang="coffee">
import SessionsResource from '../../resources/sessions_resource'

export default
  props:
    parent_session: null

  data: ->
    session: null
    session_id: null

  methods:
    loadSession: ->
      @sessions_resource.get @session_id, @sessionLoaded

    sessionLoaded: (response) ->
      @session = response.session

  mounted: ->
    if @parent_session
      @session = @parent_session
      return

    @sessions_resource = new SessionsResource
    @session_id = @$route.params.id
    @loadSession()
</script>
