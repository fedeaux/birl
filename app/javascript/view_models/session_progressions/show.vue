<template lang="pug">
.entity-show-wrapper.session_progressions-show-wrapper.default-container.with-footer
  .entity-show.session_progressions-show(v-if='session_progression')
    h1.entity-show-header
      | {{ session_progression.name }}

  shared-footer(v-if='session_progression')
    router-link.ui.fluid.red.basic.button(:to='session_progression.editPath()')
      | Edit
</template>

<script lang="coffee">
import SessionProgressionsResource from '../../resources/session_progressions_resource'

export default
  data: ->
    session_progression: null
    session_progression_id: null

  methods:
    loadSessionProgression: ->
      @session_progressions_resource.get @session_progression_id, @session_progressionLoaded

    session_progressionLoaded: (response) ->
      @session_progression = response.session_progression

  mounted: ->
    @session_progressions_resource = new SessionProgressionsResource
    @session_progression_id = @$route.params.id
    @loadSessionProgression()
</script>
