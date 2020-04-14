<template lang="pug">
  .desktop-home.flex-row.padded-1
    .desktop-home-tags-and-memes.flex-column.grow-3
      .padded-1.flex-column
        .desktop-home-tags.desktop-home-card.flex-column.padded-1
          h1.flex-item-fixed.centered Tags
          shared-view.flex-item(:path='"/tags"')

      .padded-1.flex-column
        .desktop-home-tags.desktop-home-card.flex-column.padded-1
          h1.flex-item-fixed.centered Memes
          shared-view.flex-item(:path='"/memes"')

    .flex-column.grow-3.padded-1
      shared-view.desktop-home-card.flex-item.padded-2(:path='"/timelogs/today"')

    .flex-column.grow-3.padded-1
      .desktop-home-card.flex-column.padded-2
        h1.flex-item-fixed.centered Periods
        goaler-periods.flex-item.scroll-y

    .flex-column.grow-6.padded-1
      .desktop-home-card.flex-column.padded-2
        h1.flex-item-fixed.centered Goaler
        shared-view.flex-item.scroll-y(:path='"/goaler"')
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
