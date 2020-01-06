<template lang="pug">
.entity-index.memes-index.default-container
  memes-manager(:memes='memes')
</template>

<script lang="coffee">
import MemesResource from '../../resources/memes_resource'

export default
  data: ->
    memes: null

  methods:
    loadMemes: ->
      @memes_resource.index @memesLoaded

    memesLoaded: (response) ->
      @memes = response.memes

  mounted: ->
    @memes_resource = new MemesResource
    @loadMemes()
</script>
