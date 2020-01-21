<template lang="pug">
mobile-index(v-if='device == "mobile"')
desktop-index(v-else-if='device == "desktop"')
</template>

<script lang="coffee">
export default
  data: ->
    force_mobile: false
    force_desktop: false

  computed:
    device: ->
      return 'mobile' if @force_mobile or (!@force_desktop and window.innerWidth < window.innerHeight)
      'desktop'

  methods:
    logoff: ->
      $.ajax
        method: 'delete'
        url: Global.server.links.logoff
        complete: (a, b, c) ->
          console.log a, b, c

  created: ->
    @setInitialUser()

</script>
