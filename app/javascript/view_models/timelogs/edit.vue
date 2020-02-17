<template lang="pug">
.entity-edit.timelog-edit.default-container
  .entity-display
    .entity-display-main Edit Timelog

  timelogs-form(v-model='timelog'
                v-if='timelog'
                @save='saveTimelog()'
                @cancel='timelogDone()')
</template>

<script lang="coffee">

import TimelogsResource from '../../resources/timelogs_resource'
import Timelog from '../../models/timelog'

export default
  props:
    timelog_id:
      default: null

  data: ->
    timelog: null

  methods:
    loadTimelog: ->
      @timelogs_resource.get @timelog_id, @timelogLoaded

    timelogLoaded: (response) ->
      @timelog = response.timelog

    saveTimelog: ->
      @timelogs_resource.save @timelog, @timelogDone

    timelogDone: ->
      @$router.push @timelog.path()

  mounted: ->
    @timelogs_resource = new TimelogsResource
    @loadTimelog()
</script>
