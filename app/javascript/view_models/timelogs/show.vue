<template lang="pug">
.entity-show-wrapper.timelogs-show-wrapper.default-container(v-if='timelog')
  .header-contents-footer
    .entity-show.timelogs-show.header-contents-footer-header
      timelogs-display(:timelog='timelog')
        shared-link.entity-show-header-actions(:to='timelog.editPath()')
          i.edit.icon

    //- BrainDamage: Body Start
    //- BrainDamage: Body End
</template>

<script lang="coffee">
import TimelogsResource from '../../resources/timelogs_resource'

export default
  props:
    parent_timelog: null
    timelog_id:
      default: null

  data: ->
    timelog: null

  methods:
    loadTimelog: ->
      return unless @timelog_id
      @timelogs_resource.get @timelog_id, @timelogLoaded

    timelogLoaded: (response) ->
      @timelog = response.timelog

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @timelog = @parent_timelog if @parent_timelog
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    timelog_id:
      immediate: true
      handler: ->
        @timelogs_resource ?= new TimelogsResource
        @loadTimelog()
</script>
