<template lang="pug">
.meme-list.flex-column
  .flex-item-fixed
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .flex-item.scroll-y
    .memes-list-items-wrapper
      memes-list-item(v-for='meme in displayable_memes'
                      v-if='memes'
                      :meme='meme'
                      :allow_actions='allow_actions'
                      :key='meme.id'
                      @edit='$emit("edit", { meme: meme })'
                      @destroy='$emit("destroy", { meme: meme })')

      entity-list-empty(v-if='!memes || memes.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    memes:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (meme) ->
      (@filter.text == '' or meme.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_memes: ->
      return [] unless @memes

      (meme for meme in @memes when @matchFilters meme)
</script>
