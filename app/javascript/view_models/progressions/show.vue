<template lang="pug">
.entity-show-wrapper.progressions-show-wrapper.default-container.with-footer(v-if='progression')
  .entity-show.progressions-show
    h1.entity-show-header
      | {{ progression.name }}

    p.centered
      | {{ progression.details }}

  br
  br

  .entity-show-subheader Entries
  entries-manager(:context='{ progression_id: progression_id }')

  progressions-in-session(:current_progression_id='progression_id')

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

  watch:
    '$route.params.id':
      immediate: true
      handler: ->
        @progressions_resource ?= new ProgressionsResource
        @progression_id = parseInt @$route.params.id
        @loadProgression()
</script>
