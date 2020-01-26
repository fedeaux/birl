<template lang="pug">
#birl-spa-container.desktop
  #contents-wrapper
    #contents
      .desktop-component.default-container(v-for='view in views')
        shared-view(:path='view')
</template>

<script lang="coffee">
  export default
    data: ->
      views: ['/memes', '/tags', '/tags/14']

    methods:
      goTo: (data) ->
        @views.push data.to

    mounted: ->
      Global.events.$on 'Desktop::GoTo', @goTo

    beforeDestroy: ->
      Global.events.$off 'Desktop::GoTo', @goTo
</script>
