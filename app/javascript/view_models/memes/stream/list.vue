<template lang="pug">
.entity-list.meme-list.header-contents-footer
  .header-contents-footer-header(v-if='show_header')
    .entity-list-filter
      inputs-clearable(v-model='filter.text')

      .ui.icon.circular.basic.button(@click='toggleType')
        i.check.square.outline.icon(v-if='filter.type == "Todo"')
        i.sticky.note.outline.icon(v-if='filter.type == "Note"')
        i.circle.outline.icon(v-if='filter.type == "all"')

      .ui.icon.circular.basic.button(@click='toggleTagged')
        i.tags.icon(v-if='filter.tags == "all"')
        i.tags.icon(v-if='filter.tags == "none"')
        i.tags.icon(v-if='filter.tags == "tagged"')

  .header-contents-footer-contents
    .meme-list-items
      memes-stream-item(v-for='(meme, index) in displayable_memes'
                        v-if='memes'
                        v-long-press='400'
                        :meme='meme'
                        :allow_actions='allow_actions'
                        :key='meme.id'
                        :selected='selected_ids[meme.id]'
                        :previous_selected='previousSelected(index)',
                        :next_selected='nextSelected(index)',
                        @long-press-stop='toggleSelectIfSelectMode(meme)'
                        @long-press-start='enableSelectMode(meme)'
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

    select_mode:
      default: false

    selected_ids:
      default: {}

    show_header:
      default: true

  data: ->
    ignore_next_select_toggle: false
    scroll_when_long_touch_started: null

    filter:
      tags: 'all'
      type: 'all'
      text: ''

  methods:
    previousSelected: (displayable_meme_index) ->
      previous_meme_index = displayable_meme_index - 1
      return false unless previous_meme_index >= 0
      @selected_ids[@displayable_memes[previous_meme_index].id]

    nextSelected: (displayable_meme_index) ->
      next_meme_index = displayable_meme_index + 1
      return false unless next_meme_index < @displayable_memes.length
      @selected_ids[@displayable_memes[next_meme_index].id]

    toggleType: ->
      return @filter.type = 'Note' if @filter.type == 'Todo'
      return @filter.type = 'all' if @filter.type == 'Note'
      @filter.type = 'Todo'

    toggleTagged: ->
      return @filter.tags = 'all' if @filter.tags == 'none'
      return @filter.tags = 'tagged' if @filter.tags == 'all'
      @filter.tags = 'none'

    matchFilters: (meme) ->
      (@filter.type == 'all' or meme.type == @filter.type) and
      (@filter.tags == 'all' or
        (@filter.tags == 'none' and meme.tags.length == 0) or
        (@filter.tags == 'tagged' and meme.tags.length > 0)) and
      (@filter.text == '' or meme.contents.title.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

    enableSelectMode: (meme) ->
      return if @select_mode or @scroll_when_long_touch_started != $('html')[0].scrollTop
      @ignore_next_select_toggle = true

      @$emit 'enableSelectMode', meme: meme

    toggleSelectIfSelectMode: (meme) ->
      @scroll_when_long_touch_started = $('html')[0].scrollTop
      return unless @select_mode
      return @ignore_next_select_toggle = false if @ignore_next_select_toggle

      @$emit 'selectModeToggleSelected', meme: meme

  computed:
    displayable_memes: ->
      return [] unless @memes
      (meme for meme in @memes when @matchFilters meme)
</script>
