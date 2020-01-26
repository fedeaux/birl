<template lang="pug">
mobile-index(v-if='mobile')
desktop-index(v-else-if='desktop')
</template>

<script lang="coffee">
export default
  data: ->
    # force: 'mobile'
    # force: 'desktop'
    force: null

  methods:
    resolveDevice: ->
      return @force if @force
      return 'mobile' if window.innerWidth < window.innerHeight
      'desktop'

    logoff: ->
      $.ajax
        method: 'delete'
        url: Global.server.links.logoff
        complete: (a, b, c) ->
          console.log a, b, c

  created: ->
    @setInitialUser()
    @setDevice @resolveDevice()

</script>
