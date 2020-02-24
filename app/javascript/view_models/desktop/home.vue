<template lang="pug">
  .flex-views
    .flex-view
      shared-view(:path='"/tags"')
    .flex-view.grow-2
      shared-view(:path='"/timelogs/today"')
    .flex-view
      shared-view(:path='"/memes"')
</template>

<script lang="coffee">
  export default
    data: ->
      # views: ['/tags', '/memes', '/timelogs/today']
      # views: ['/timelogs/week']
      views: ['/timelogs/today']

    methods:
      goTo: (data) ->
        return unless @viewIndex(data.to) == -1

        @views.push data.to

      close: (view) ->
        index = @viewIndex view
        @views.splice index, 1

      viewIndex: (view) ->
        @views.indexOf view

    mounted: ->
      Global.events.$on 'Desktop::GoTo', @goTo

    beforeDestroy: ->
      Global.events.$off 'Desktop::GoTo', @goTo
</script>
