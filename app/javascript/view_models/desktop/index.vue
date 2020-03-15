<template lang="pug">
#birl-spa-container.desktop.flex-column
  #header.fixed-flex-item
    #menu.ui.inverted.menu
      router-link.item(:to='"/"') Home
      router-link.item(:to='"/timelogs/week"') Week
      router-link.item(:to='"/statistics"') Statistics

  #contents-wrapper.flex-column
    #contents.flex-column
      router-view.flex-item
</template>

<script lang="coffee">
  export default
    data: ->
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

      requestNotificationsPermission: ->
        Notification.requestPermission().then ->
          window.serviceWorkerRegistration.showNotification('permitted')

      notify: (notification) ->
        Notification.requestPermission().then ->
          notification.options.icon = '/logo_xxxhdpi.png'
          notification.options.sound = Global.player.srcForEvent 'doit_finished', 'birl'
          notification.options.silent = false
          window.serviceWorkerRegistration.showNotification notification.title, notification.options

      currentTimelineablesChanged: (data) ->
        return unless data.added_timelineables and data.added_timelineables.length > 0

        body = data.added_timelineables[0].description || ''
        @notify title: "Starting #{data.added_timelineables[0].main_tag.fullname}", options: { body: body }

    mounted: ->
      Global.events.$on 'Desktop::GoTo', @goTo
      Global.events.$on 'Timeline::CurrentTimelineables', @currentTimelineablesChanged

    beforeDestroy: ->
      Global.events.$off 'Desktop::GoTo', @goTo
      Global.events.$off 'Timeline::CurrentTimelineables', @currentTimelineablesChanged
</script>
