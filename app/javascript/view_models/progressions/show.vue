<template lang="pug">
.entity-show-wrapper.progressions-show-wrapper.default-container(v-if='progression')
  .entity-show.progressions-show
    progressions-display(:progression='progression')
      router-link.entity-show-header-actions(:to='progression.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  entries-manager(:context='{ progression_id: progression.id }'
                  :data_model='progression.entry_data_model')

  shared-footer
    .ui.two.column.centered.grid
      .column
       router-link.ui.primary.icon.fluid.button(:to='progression.executePath()')
         | Execute
         | &nbsp;
         i.play.icon
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import ProgressionsResource from '../../resources/progressions_resource'

export default
  props:
    parent_progression: null

  data: ->
    progression: null
    progression_id: null

  methods:
    loadProgression: ->
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
    '$route.params.id':
      immediate: true
      handler: ->
        @progressions_resource ?= new ProgressionsResource
        @progression_id = parseInt @$route.params.id
        @loadProgression()
</script>
