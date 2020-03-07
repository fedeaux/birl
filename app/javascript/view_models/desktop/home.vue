<template lang="pug">
  .flex-columns
    .flex-rows.flex-item.h-padded-2.v-paddeds-2
      .flex-item
        shared-view(:path='"/tags"')

      .flex-item(v-if='timelineable_tag')
        shared-view(:path='timelineable_tag.path()')

      .flex-item(v-else)
        shared-view(:path='"/memes"')

    .flex-item.v-padded-2.grow-2
      shared-view(:path='"/timelogs/today"')

    .flex-item
      .padded-2
        shared-view(:path='"/goaler"')

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
