<template lang="pug">
.memes-show-wrapper.flex-column.t-padded-2(v-if='meme')
  .memes-show.flex-item-fixed
    memes-display(:meme='meme')
      shared-link.action-text(:to='meme.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import MemesResource from '../../resources/memes_resource'

export default
  props:
    parent_meme: null
    meme_id:
      default: null

  data: ->
    meme: null

  methods:
    loadMeme: ->
      return unless @meme_id
      @memes_resource.get @meme_id, @memeLoaded

    memeLoaded: (response) ->
      @meme = response.meme

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @meme = @parent_meme if @parent_meme
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    meme_id:
      immediate: true
      handler: ->
        @memes_resource ?= new MemesResource
        @loadMeme()
</script>
