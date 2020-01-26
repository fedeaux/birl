<template lang="pug">
.entity-show-wrapper.progressions-show-wrapper.default-container(v-if='progression')
  .entity-show.progressions-show
    progressions-display(:progression='progression')
      shared-link.entity-show-header-actions(:to='progression.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  entries-manager(:context='{ progression_id: progression.id }'
                  :data_model='progression.entry_data_model')

  shared-footer
    .ui.two.column.centered.grid
      .column
       shared-link.ui.primary.icon.fluid.button(:to='progression.executePath()')
         | Go to Executor
         | &nbsp;
         i.play.icon
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import ProgressionsResource from '../../resources/progressions_resource'

export default
  props:
    parent_progression: null
    progression_id:
      default: null

  data: ->
    progression: null

  methods:
    loadProgression: ->
      return unless @progression_id
      @progressions_resource.get @progression_id, @progressionLoaded

    progressionLoaded: (response) ->
      @progression = response.progression

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @progression = @parent_progression if @parent_progression
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    progression_id:
      immediate: true
      handler: ->
        @progressions_resource ?= new ProgressionsResource
        @loadProgression()
</script>
