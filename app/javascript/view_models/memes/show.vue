<template lang="pug">
.entity-show-wrapper.memes-show-wrapper.default-container(v-if='meme')
  .entity-show.memes-show
    memes-display(:meme='meme')
      shared-link.entity-show-header-actions(:to='meme.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  tags-tags(:tags='meme.tags')
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
