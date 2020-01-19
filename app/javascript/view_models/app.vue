<template lang="pug">
mobile-index(v-if='device == "mobile"')
desktop-index(v-else-if='device == "desktop"')
</template>

<script lang="coffee">
export default
  computed:
    device: ->
      'mobile'

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
