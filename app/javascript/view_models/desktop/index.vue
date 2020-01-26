<template lang="pug">
#birl-spa-container.desktop
  #header
    #menu.ui.inverted.menu
      shared-link.item(to='/tags') Tags
      shared-link.item(to='/memes') Memes

  #contents-wrapper
    #contents
      .desktop-component.default-container(v-for='view in views')
        .desktop-component-close(@click='close(view)')
          i.cancel.icon

        shared-view(:path='view')
</template>

<script lang="coffee">
  export default
    data: ->
      views: ['/memes', '/tags']

    methods:
      goTo: (data) ->
        return unless @viewIndex(data.to) == -1

        @views.push data.to

      close: (view) ->
        index = @viewIndex view
        @views.splice index

      viewIndex: (view) ->
        @views.indexOf view

    mounted: ->
      Global.events.$on 'Desktop::GoTo', @goTo

    beforeDestroy: ->
      Global.events.$off 'Desktop::GoTo', @goTo
</script>
