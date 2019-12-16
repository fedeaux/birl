<template lang="pug">
.entity-show-wrapper.progressions-show-wrapper.default-container(v-if='progression')
  .entity-show.progressions-show
    progressions-display(:progression='progression')

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
      @progression.entry_data_model = {
        fields: { rest: {}, repetitions: {}, weight: {} }
      }

      @new_entry = new Entry(
        progression_id: @progression.id,
        values: {
          sets: [
            {
              weight: 35
              reps: 10
              rest: 20
              execution: 'slow'
            }
            {
              weight: 30
              reps: 12
              rest: 20
            }
            {
              weight: 25
              reps: 15
              rest: 20
            }
            {
              weight: 20
              reps: 18
              rest: 0
            }
          ]
        }
      )

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
