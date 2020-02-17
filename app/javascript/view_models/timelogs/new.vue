<template lang="pug">
.entity-new.timelog-new.default-container
  .entity-display
    .entity-display-main New Timelog

  timelogs-form(v-model='timelog'
                @save='saveTimelog'
                @cancel='back')
</template>

<script lang="coffee">

import TimelogsResource from '../../resources/timelogs_resource'
import Timelog from '../../models/timelog'

export default
  data: ->
    timelog: new Timelog

  methods:
    saveTimelog: ->
      @timelogs_resource.save @timelog, @saved

    saved: (data) ->
      @$router.push data.timelog.path()

    back: ->
      @$router.push @timelog.collectionPath()

  mounted: ->
    @timelogs_resource = new TimelogsResource
</script>
