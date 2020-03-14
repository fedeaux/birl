<template lang="pug">
timelogs-manager.timelogs-index(:parent_timelogs='timelogs')
</template>

<script lang="coffee">
import TimelogsResource from '../../resources/timelogs_resource'

export default
  data: ->
    timelogs: null

  methods:
    loadTimelogs: ->
      @timelogs_resource.index @timelogsLoaded

    timelogsLoaded: (response) ->
      @timelogs = response.timelogs

  mounted: ->
    @timelogs_resource = new TimelogsResource
    @loadTimelogs()
</script>
