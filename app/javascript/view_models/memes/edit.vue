<template lang="pug">
.entity-edit.meme-edit.default-container
  .entity-display
    .entity-display-main Edit Meme

  memes-form(v-model='meme'
             v-if='meme'
             @save='saveMeme()'
             @cancel='memeDone()')
</template>

<script lang="coffee">

import MemesResource from '../../resources/memes_resource'
import Meme from '../../models/meme'

export default
  props:
    meme_id:
      default: null

  data: ->
    meme: null

  methods:
    loadMeme: ->
      @memes_resource.get @meme_id, @memeLoaded

    memeLoaded: (response) ->
      @meme = response.meme

    saveMeme: ->
      @memes_resource.save @meme, @memeDone

    memeDone: ->
      @$router.push @meme.path()

  mounted: ->
    @memes_resource = new MemesResource
    @loadMeme()
</script>
