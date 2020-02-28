<template lang="pug">
mobile-index(v-if='mobile' :title='title')
desktop-index(v-else-if='desktop')
</template>

<script lang="coffee">

import Device from '../lib/device'

export default
  data: ->
    # force: 'mobile'
    # force: 'desktop'
    force: null
    title: ''

  methods:
    resolveDevice: ->
      return new Device @force if @force
      return new Device 'mobile' if window.innerWidth < window.innerHeight
      new Device 'desktop'

    logoff: ->
      $.ajax
        method: 'delete'
        url: Global.server.links.logoff
        complete: (a, b, c) ->
          console.log a, b, c

    setTitle: (data) ->
      @title = data.title
      document.title = @title

  created: ->
    @setInitialUser()
    @setDevice @resolveDevice()
    Global.events.$on 'SetTitle', @setTitle

  beforeDestroy: ->
    Global.events.$off 'SetTitle', @setTitle

</script>
