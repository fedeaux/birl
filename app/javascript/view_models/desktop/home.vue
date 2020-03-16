<template lang="pug">
  .desktop-home.flex-row
    .flex-column.grow-6.padded-1
      .flex-row.paddeds-1
        .desktop-home-tags.flex-column
          h1.flex-item-fixed.centered Tags
          shared-view.flex-item(:path='"/tags"')

        .desktop-home-memes.flex-column
          h1.flex-item-fixed.centered Memes
          template(v-if='timelineable_tag')
            shared-view.flex-item(:path='timelineable_tag.path()')

          template(v-else)
            shared-view.flex-item(:path='"/memes"')

      .flex-item

    shared-view.flex-item.grow-6.padded-1(:path='"/timelogs/today"')

    .desktop-home-tags-and-memes.flex-column.grow-8
      .flex-column.grow-3.padded-1
        h1.flex-item-fixed.centered Goaler
        shared-view.flex-item.scroll-y(:path='"/goaler"')
      .flex-item.grow-3
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
