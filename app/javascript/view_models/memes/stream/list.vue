<template lang="pug">
.entity-list.meme-list
  .entity-list-filter
    inputs-clearable(v-model='filter.text')

    .ui.icon.circular.basic.button(@click='toggleType')
      i.check.square.outline.icon(v-if='filter.type == "Todo"')
      i.sticky.note.outline.icon(v-if='filter.type == "Note"')
      i.circle.outline.icon(v-if='filter.type == "all"')

  memes-stream-item(v-for='meme in displayable_memes'
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
      type: 'all'
      text: ''

  methods:
    toggleType: ->
      return @filter.type = 'Note' if @filter.type == 'Todo'
      return @filter.type = 'all' if @filter.type == 'Note'
      @filter.type = 'Todo'

    matchFilters: (meme) ->
      (@filter.type == 'all' or meme.type == @filter.type) and
        (@filter.text == '' or meme.contents.title.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_memes: ->
      return [] unless @memes
      (meme for meme in @memes when @matchFilters meme)
</script>
