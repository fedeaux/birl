<template lang="pug">
.entity-stream.memes-stream
  .entity-stream-form(v-if='form_meme')
    memes-form(v-model='form_meme'
               @save='saveFormMeme()'
               @cancel='clearFormMeme()')

  .entity-stream-list(v-else)
    memes-stream-list(:memes='memes'
                      :allow_actions='true'
                      @edit='editMeme($event)'
                      @destroy='destroyMeme($event)')

  shared-footer.seamless
    .meme-input-wrapper
      .ui.icon.circular.basic.button(@click='toggleType')
        i.check.square.outline.icon(v-if='meme_type == "Todo"')
        i.sticky.note.outline.icon(v-if='meme_type == "Note"')
      .ui.input
        input(v-model='meme_contents_title' @keyup='detectEnters')
      .ui.green.icon.circular.button(@click='createMemeFromTitle' :class='{ disabled: meme_contents_title.length == 0 }')
        i.chevron.right.icon
</template>

<script lang="coffee">
import MemesManagerMixin from '../../../mixins/memes/manager'
import Meme from '../../../models/meme'

export default
  mixins: [MemesManagerMixin]

  data: ->
    meme_contents_title: ''
    add_new: 'after'
    meme_type: 'Note'

  methods:
    toggleType: ->
      return @meme_type = 'Note' if @meme_type == 'Todo'
      @meme_type = 'Todo'

    createMemeFromTitle: ->
      return unless @meme_contents_title.length > 0
      @createMeme (new Meme contents: { title: @meme_contents_title }, type: @meme_type), @customMemeSaved

    customMemeSaved: ->
      @meme_contents_title = ''

    detectEnters: (e) ->
      return unless e.which == 13
      @createMemeFromTitle()

</script>
