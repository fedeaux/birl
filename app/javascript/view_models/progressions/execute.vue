<template lang="pug">
.entity-show-wrapper.progressions-show-wrapper.default-container(v-if='progression')
  .entity-show.progressions-show
    progressions-display(:progression='progression')

  entries-manager(:context='{ progression_id: progression_id }'
                  :data_model='progression.entry_data_model')

  shared-footer(v-if='current_session && current_session.progressions')
    progressions-in-session(:current_progression_id='progression_id')
</template>

<script lang="coffee">
import ProgressionsResource from '../../resources/progressions_resource'
import Entry from '../../models/entry'

export default
  props:
    parent_progression: null

  data: ->
    progression: null
    progression_id: null
    new_entry: null
    current_set: -1

  methods:
    loadProgression: ->
      @progressions_resource.get @progression_id, @progressionLoaded

    progressionLoaded: (response) ->
      @progression = response.progression

  mounted: ->
    if @parent_progression
      @progression = @parent_progression
      return

    @progressions_resource = new ProgressionsResource
    @progression_id = parseInt @$route.params.id
    @loadProgression()

  watch:
    '$route.params.id':
      immediate: true
      handler: ->
        @progressions_resource ?= new ProgressionsResource
        @progression_id = parseInt @$route.params.id
        @loadProgression()
</script>
