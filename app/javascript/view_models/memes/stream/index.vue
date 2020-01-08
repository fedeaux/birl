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
    onMemeAdded: ->
      @$nextTick =>
        @scrollDown()

    onMemesLoaded: ->
      @$nextTick =>
        @scrollDown()

    scrollDown: ->
      # More duct tape... kkkk
      $('html')[0].scrollTop = 612873612897361289372

      # c = $ '.entity-stream-list', @$el
      # i = 0

      # loop
      #   e = c[0]
      #   break unless e
      #   e.scrollTop = e.scrollHeight * 20
      #   c = c.parent()
      #   console.log c
      #   i += 1
      #   break if i > 6

    toggleType: ->
      return @meme_type = 'Note' if @meme_type == 'Todo'
      @meme_type = 'Todo'

    createMemeFromTitle: ->
      return unless @meme_contents_title.length > 0
      @createMeme (@buildMeme contents: { title: @meme_contents_title }, type: @meme_type), @customMemeSaved

    customMemeSaved: ->
      @meme_contents_title = ''

    detectEnters: (e) ->
      return unless e.which == 13 and not e.shiftKey
      @createMemeFromTitle()

</script>
