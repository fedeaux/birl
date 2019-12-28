<template lang="pug">
.entity-manager.vocabularies-manager.default-container
  .entity-manager-form(v-if='form_vocabulary')
    vocabularies-form(v-model='form_vocabulary'
                      @save='saveFormVocabulary()'
                      @cancel='clearFormVocabulary()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-vocabulary-button.ui.primary.top.attached.fluid.small.icon.button(@click='newVocabulary')
        i.plus.icon
        |  Add Vocabulary

    vocabularies-list(:vocabularies='vocabularies'
                      :allow_actions='true'
                      @edit='editVocabulary($event)'
                      @destroy='destroyVocabulary($event)')
</template>

<script lang="coffee">
import VocabulariesResource from '../../resources/vocabularies_resource'
import Vocabulary from '../../models/vocabulary'

export default
  props:
    context:
      default: -> {}

    parent_vocabularies: null

  data: ->
    vocabularies: null
    form_vocabulary: null

  methods:
    editVocabulary: (data) ->
      @setFormVocabulary data.vocabulary

    destroyVocabulary: (data) ->
      @vocabularies_resource.destroy data.vocabulary, @vocabularyRemoved

    loadVocabularies: ->
      @vocabularies_resource.index @vocabulariesLoaded, @context

    vocabulariesLoaded: (response) ->
      @vocabularies = response.vocabularies

    newVocabulary: ->
      @setFormVocabulary new Vocabulary @context

    setFormVocabulary: (@form_vocabulary) ->

    clearFormVocabulary: ->
      @setFormVocabulary null

    vocabularyIndex: (vocabulary_id) ->
      for index, vocabulary of @vocabularies
        return index if vocabulary.id == vocabulary_id

      -1

    saveFormVocabulary: ->
      @vocabularies_resource.save @form_vocabulary, @vocabularySaved

    addVocabulary: (vocabulary) ->
      index = @vocabularyIndex vocabulary.id

      if index == -1
        @vocabularies.push vocabulary
        return

      Vue.set @vocabularies, index, vocabulary

    vocabularySaved: (data) ->
      @addVocabulary data.vocabulary
      @clearFormVocabulary()

    vocabularyRemoved: (data) ->
      index = @vocabularyIndex data.vocabulary.id
      return if index == -1
      @vocabularies.splice index, 1

  mounted: ->
    @vocabularies_resource = new VocabulariesResource

    if @parent_vocabularies
      @vocabularies = @parent_vocabularies
      return

    @loadVocabularies()
</script>
