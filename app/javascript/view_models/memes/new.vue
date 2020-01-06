<template lang="pug">
.entity-new.meme-new.default-container
  .entity-display
    .entity-display-main New Meme

  memes-form(v-model='meme'
             @save='saveMeme'
             @cancel='back')
</template>

<script lang="coffee">

import MemesResource from '../../resources/memes_resource'
import Meme from '../../models/meme'

export default
  data: ->
    meme: new Meme

  methods:
    saveMeme: ->
      @memes_resource.save @meme, @saved

    saved: (data) ->
      @$router.push data.meme.path()

    back: ->
      @$router.push @meme.collectionPath()

  mounted: ->
    @memes_resource = new MemesResource
</script>
