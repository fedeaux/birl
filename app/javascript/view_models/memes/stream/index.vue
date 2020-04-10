<template lang="pug">
.memes-stream-index.flex-column
  .memes-stream-header.flex-item-fixed
    //- .select-mode-menu.action-menu
    .memes-stream-select-mode-wrapper(v-if='select_mode')
      template(v-if='tagging_selected')
        h3 Pick Tags
        tag-taggables-picker(v-model='selected_tags')

        .ui.two.buttons
          .ui.primary.button(@click='tagSelected()' v-if='selected_tags.length > 0') Tag All
          .ui.button(@click='stopTaggingSelected()') Cancel

      template(v-else)
        .action-menu-item
           i.tag.purple.icon(@click='startTaggingSelected()')

      .action-menu-item(@click='disableSelectMode()')
         i.cancel.icon

    .entity-stream-form(v-if='form_meme')
      memes-form(v-model='form_meme'
                 @save='saveFormMeme()'
                 @cancel='clearFormMeme()')

  .memes-stream-list-wrapper.flex-column.b-padded-1(v-if='!form_meme')
    memes-stream-list.padded-1.flex-item(:memes='memes'
                                         :allow_actions='true'
                                         :context='context'
                                         :select_mode='select_mode'
                                         :selected_ids='selected_ids'
                                         :show_header='!select_mode'
                                         @enableSelectMode='enableSelectMode'
                                         @selectModeToggleSelected='selectModeToggleSelected'
                                         @edit='editMeme($event)'
                                         @destroy='destroyMeme($event)')

  //- .action-footer.slim-bottom-attached-footer
  .memes-stream-input-wrapper.flex-item.grow-0.flex-row
    .flex-item.grow-0
      .ui.icon.circular.basic.button(@click='toggleType')
        i.check.square.outline.icon(v-if='meme_type == "Todo"')
        i.sticky.note.outline.icon(v-if='meme_type == "Note"')
    .flex-item.ui.circular.input.h-padded-1
      input(v-model='meme_contents_title' @keyup='detectEnters')
    .flex-item.grow-0
      .ui.green.icon.circular.button(@click='createMemeFromTitle' :class='{ disabled: meme_contents_title.length == 0 }')
        i.chevron.right.icon
</template>

<script lang="coffee">
import TagTaggablesResource from '../../../resources/tag_taggables_resource'
import MemesManagerMixin from '../../../mixins/memes/manager'
import Meme from '../../../models/meme'

export default
  mixins: [MemesManagerMixin]

  data: ->
    meme_contents_title: ''
    add_new: 'after'
    meme_type: 'Note'
    select_mode: false
    selected_ids: {}
    selected_tags: []
    tagging_selected: false

  methods:
    enableSelectMode: (data) ->
      @select_mode = true
      @selectModeToggleSelected data

    disableSelectMode: ->
      @select_mode = false
      @selected_ids = {}

    selectModeToggleSelected: (data) ->
      return unless data and data.meme and data.meme.id

      if @selected_ids[data.meme.id]
        return Vue.set @selected_ids, data.meme.id, false

      Vue.set @selected_ids, data.meme.id, true

    onMemeAdded: ->
      @$nextTick =>
        @scrollDown()

    onMemesLoaded: ->
      @$nextTick =>
        @scrollDown()

    scrollDown: ->
      # More duct tape... kkkk
      # parent = $ '.meme-list .flex-item'
      # parent[0].scrollTop = $('.meme-list-items', parent).height()

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

    confirmBatchDestroy: ->

    startTaggingSelected: ->
      @tagging_selected = true

    stopTaggingSelected: ->
      @tagging_selected = false
      @selected_tags = []

    tagSelected: ->
      @ttr ?= new TagTaggablesResource

      data = {
        tags_ids: (tag.id for tag in @selected_tags)
        taggables: ({ type: 'Meme', id: id } for id in Object.keys(@selected_ids))
      }

      @ttr.batchEnsureTags data, @selectedTagged

    selectedTagged: ->
      @stopTaggingSelected()
      @disableSelectMode()
      @loadMemes()

</script>
