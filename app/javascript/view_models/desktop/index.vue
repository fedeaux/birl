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
        @views.push data.to

      close: (view) ->
        index = @views.indexOf view
        @views.splice index

    mounted: ->
      Global.events.$on 'Desktop::GoTo', @goTo

    beforeDestroy: ->
      Global.events.$off 'Desktop::GoTo', @goTo
</script>
