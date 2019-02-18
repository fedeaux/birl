<template lang="pug">
.entity-show-wrapper.progressions-show-wrapper.default-container.with-footer
  .entity-show.progressions-show(v-if='progression')
    h1.entity-show-header
      | {{ progression.name }}

    h2.entity-show-subheader Progressions
    progressions-manager(:context='{ progression_id: progression.id }')

  shared-footer(v-if='progression')
    router-link.ui.fluid.red.basic.button(:to='progression.editPath()')
      | Edit
</template>

<script lang="coffee">
import ProgressionsResource from '../../resources/progressions_resource'

export default
  data: ->
    progression: null
    progression_id: null

  methods:
    loadProgression: ->
      @progressions_resource.get @progression_id, @progressionLoaded

    progressionLoaded: (response) ->
      @progression = response.progression

  mounted: ->
    @progressions_resource = new ProgressionsResource
    @progression_id = @$route.params.id
    @loadProgression()
</script>
