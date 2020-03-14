<template lang="pug">
  .desktop-home.flex-row
    .flex-item.flex-column.h-padded-2.v-paddeds-2.grow-2
      .flex-item
        h1 Tags
        shared-view(:path='"/tags"')

      //- One of these two
      .flex-item(v-if='timelineable_tag')
        h1
          | {{ timelineable_tag.fullname }} Memes
        shared-view(:path='timelineable_tag.path()')

      .flex-item(v-else)
        shared-view(:path='"/memes"')

    .flex-item.v-padded-2.grow-3
      h1 Today
      shared-view(:path='"/timelogs/today"')

    .flex-item.v-padded-2.grow-3
      h1 goaler
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
