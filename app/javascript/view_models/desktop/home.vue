<template lang="pug">
  .desktop-home.flex-row
    //- .h-padded-2.v-paddeds-2.grow-2
    .desktop-home-tags-and-memes.flex-item.flex-column
      .desktop-home-tags.flex-column.padded-1
        h1.flex-item-fixed Tags
        shared-view.flex-item(:path='"/tags"')

      //- One of these two
      .desktop-home-memes.flex-column.padded-1
        template(v-if='timelineable_tag')
          h1.flex-item-fixed
            | {{ timelineable_tag.fullname }} Memes
          shared-view.flex-item(:path='timelineable_tag.path()')

        template(v-else)
          h1.flex-item-fixed Memes
          shared-view.flex-item(:path='"/memes"')

    //- .v-padded-2
    .flex-column.grow-3.padded-1
      h1.flex-item-fixed Today
      shared-view.flex-item.scroll-y(:path='"/timelogs/today"')

    //- .v-padded-2
    .flex-column.grow-2.padded-1
      h1.flex-item-fixed Goaler
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
