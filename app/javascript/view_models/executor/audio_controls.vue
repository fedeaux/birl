<template lang="pug">
  .audio-controls(@click='toggle')
    i.volume.up.icon(v-if='audio_schema == "default"')
    i.volume.off.icon(v-if='audio_schema == null')
    img(:src='image' v-if='audio_schema == "birl"')
</template>

<script lang="coffee">
  export default
    methods:
      toggle: ->
        new_schema = 'default'

        if @audio_schema == 'default'
          new_schema = 'birl'
        else if @audio_schema == 'birl'
          new_schema = null

        @setAudioSchema new_schema

    computed:
      image: ->
        Global.player.image 'birl'
</script>
