<template lang="pug">
  .flex-views
    .flex-view
      shared-view(:path='"/tags"')
    .flex-view.grow-2
      shared-view(:path='"/timelogs/today"')
    .flex-view(v-if='timelineable_tag')
      shared-view(:path='timelineable_tag.path()')
    .flex-view(v-else)
      shared-view(:path='"/memes"')
</template>

<script lang="coffee">
  export default
    data: ->
      timelineable_tag: null

    methods:
      currentTimelineablesChanged: (data) ->
        return unless data.added_timelineables and data.added_timelineables.length > 0
        @timelineable_tag = data.added_timelineables[0].main_tag

    mounted: ->
      Global.events.$on 'Timeline::CurrentTimelineables', @currentTimelineablesChanged

    beforeDestroy: ->
      Global.events.$off 'Timeline::CurrentTimelineables', @currentTimelineablesChanged

</script>
