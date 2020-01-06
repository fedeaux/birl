<template lang="pug">
  shared-modal(v-if='form_meme' title='New Meme')
    memes-form(v-model='form_meme'
                   @save='saveFormMeme()'
                   @cancel='clearFormMeme()')

  sui-dropdown(:options='memes_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Meme'
               v-else
               v-model='selected_meme_id')

</template>

<script lang="coffee">
import MemesManagerMixin from '../../mixins/memes/manager'

export default
  mixins: [MemesManagerMixin]

  model:
    prop: 'meme_id'

  props:
    meme_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_meme_id: null

  methods:
    memeAdded: (index, meme) ->
      @selectMeme meme

    selectMeme: (meme) ->
      @selected_meme_id = parseInt meme.id

  computed:
    loading: ->
      !@memes

    memes_as_options: ->
      return [] unless @memes
      { key: meme.id, value: meme.id, text: meme.name } for meme in @memes

  watch:
    selected_meme_id: ->
      selected_meme_id = parseInt @selected_meme_id

      unless isNaN selected_meme_id
        @$emit 'input', selected_meme_id
        return

      @newMeme name: @selected_meme_id

    meme_id:
      immediate: true
      handler: ->
        return unless @meme_id
        @selected_meme_id = parseInt @meme_id

</script>
