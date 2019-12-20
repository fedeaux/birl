<template lang="pug">
  .audio-controls(@click='toggle')
    i.volume.up.icon(v-if='schema() == "default"')
    i.volume.off.icon(v-if='schema() == null')
    img(:src='image' v-if='schema() == "birl"')
</template>

<script lang="coffee">
  export default
    methods:
      toggle: ->
        new_schema = 'default'

        if @schema() == 'default'
          new_schema = 'birl'
        else if @schema() == 'birl'
          new_schema = null

        Vue.set Global.player, 'schema', new_schema
        @$forceUpdate()

      schema: ->
        Global.player.schema

    computed:
      image: ->
        Global.player.image 'birl'
</script>
