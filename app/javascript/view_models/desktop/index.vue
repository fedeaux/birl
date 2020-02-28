<template lang="pug">
#birl-spa-container.desktop
  #header
    #menu.ui.inverted.menu
      router-link.item(:to='"/"') Home
      router-link.item(:to='"/timelogs/week"') Week
      .item(@click='requestNotificationsPermission') Notifications

  #contents-wrapper
    #contents
      router-view.slim-container
      //- .desktop-component.default-container(v-for='view in views')
      //-   .desktop-component-close(@click='close(view)')
      //-     i.cancel.icon

      //-   shared-view(:path='view')
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

      requestNotificationsPermission: ->
        Notification.requestPermission().then ->
          window.serviceWorkerRegistration.showNotification('oe')

    mounted: ->
      Global.events.$on 'Desktop::GoTo', @goTo

    beforeDestroy: ->
      Global.events.$off 'Desktop::GoTo', @goTo
</script>
