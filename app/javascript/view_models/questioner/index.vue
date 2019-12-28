<template lang="pug">
.questioner(:class='klass')
  .ui.form(v-if='state == "preparing"')
    .field
      label Count
      sui-dropdown(:options='count_as_options'
                   :selection='true'
                   placeholder='Count'
                   v-model='count')

    .field
      label Direction
      sui-dropdown(:options='directions_as_options'
                   :selection='true'
                   placeholder='Direction'
                   v-model='direction')

    .field
      label Kinds
      .questioner-kind-picker
        template(v-for='kind in kinds')
          .ui.yellow.label(v-if='isSelected(kind)' @click='toogleSelectedKind(kind)') {{ kind }}
          .ui.basic.label(v-else @click='toogleSelectedKind(kind)') {{ kind }}

    br
    br

    .ui.primary.fluid.icon.button(@click='start')
      | Start&nbsp;
      i.play.icon

  .questioner-components(v-if='state == "playing"')
    vocabularies-form(v-if='form_vocabulary'
                      v-model='form_vocabulary'
                      @save='saveFormVocabulary()'
                      @cancel='clearFormVocabulary()')

    questioner-item(v-else
                    :direction='direction'
                    :vocabulary='current_vocabulary'
                    :show_answer='show_answer'
                    @showAnswer='showAnswer'
                    @right='right'
                    @wrong='wrong'
                    @edit='edit'
                    @destroy='destroy'
                    @back='back')

  .questioner-actions
    .questioner-actions-center
      i.ban.icon(@click='reset')
</template>

<script lang="coffee">

import VocabulariesResource from '../../resources/vocabularies_resource'

export default
  data: ->
    state: 'preparing'
    count: 50
    direction: 'es => pt_br'
    current_vocabulary_index: 0
    vocabularies: null
    show_answer: false
    form_vocabulary: null
    kinds: Global.vocabularies.kinds
    selected_kinds: []

  methods:
    start: ->
      @vocabularies_resource.index @vocabulariesLoaded, @options

    showAnswer: ->
      @show_answer = true

    hideAnswer: ->
      @show_answer = false

    right: ->
      if @vocabularies[@current_vocabulary_index + 1]
        @current_vocabulary_index += 1
        @hideAnswer()
        return

      @state = 'preparing'

    back: ->
      return if @current_vocabulary_index == 0

      @current_vocabulary_index -= 1
      @hideAnswer()

    wrong: ->
      vocabulary = @vocabularies.splice @current_vocabulary_index, 1
      @vocabularies.push vocabulary[0]
      @hideAnswer()

    destroy: ->
      @vocabularies_resource.destroy @current_vocabulary, @vocabularyRemoved

    edit: ->
      @setFormVocabulary @current_vocabulary

    setFormVocabulary: (@form_vocabulary) ->

    clearFormVocabulary: ->
      @setFormVocabulary null

    saveFormVocabulary: ->
      @vocabularies_resource.save @form_vocabulary, @vocabularySaved

    vocabularySaved: (data) ->
      Vue.set @vocabularies, @current_vocabulary_index, data.vocabulary
      @clearFormVocabulary()

    vocabularyRemoved: (data) ->
      @vocabularies.splice @current_vocabulary_index, 1
      @hideAnswer()

    vocabulariesLoaded: (response) ->
      @vocabularies = response.vocabularies
      @state = 'playing'

    reset: ->
      @state = 'preparing'

    isSelected: (kind) ->
      @selected_kinds.indexOf(kind) != -1

    toogleSelectedKind: (kind) ->
      index = @selected_kinds.indexOf kind

      if index != -1
        @selected_kinds.splice index, 1
      else
        @selected_kinds.push kind

  computed:
    options: ->
      {
        limit: @count,
        random: true,
        kinds: @selected_kinds
      }

    current_vocabulary: ->
      return null unless @vocabularies
      @vocabularies[@current_vocabulary_index]

    count_as_options: ->
      { key: count, value: count, text: count+'' } for count in [10, 20, 30, 50, 75, 100, 200]

    directions_as_options: ->
      { key: count, value: count, text: count } for count in ['es => pt_br', 'pt_br => es']

    fullscreen: ->
      @state != 'preparing'

    klass: ->
      classes = ["questioner-#{@state}"]
      classes.push ['questioner-fullscreen'] if @fullscreen
      classes.join ' '

  created: ->
    @vocabularies_resource = new VocabulariesResource
    @selected_kinds = JSON.parse JSON.stringify @kinds

</script>
