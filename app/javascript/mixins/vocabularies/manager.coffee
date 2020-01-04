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
    vocabularyAdded: (index, vocabulary) ->
      # console.log 'vocabularyAdded', index, vocabulary

    getVocabulary: (vocabulary_id) ->
      index = @vocabularyIndex vocabulary_id
      return null if index == -1
      @vocabularies[index]

    editVocabulary: (data) ->
      @setFormVocabulary data.vocabulary

    destroyVocabulary: (data) ->
      @vocabularies_resource.destroy data.vocabulary, @vocabularyRemoved

    loadVocabularies: ->
      @vocabularies_resource.index @vocabulariesLoaded, @context

    vocabulariesLoaded: (response) ->
      @vocabularies = response.vocabularies

    newVocabulary: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      @setFormVocabulary new Vocabulary final_params

    setFormVocabulary: (@form_vocabulary) ->

    clearFormVocabulary: ->
      @setFormVocabulary null

    vocabularyIndex: (vocabulary_id) ->
      for index, vocabulary of @vocabularies
        return index if vocabulary.id == vocabulary_id

      -1

    saveFormVocabulary: (custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @vocabularySaved(data)
          custom_callback(data)

        @vocabularies_resource.save @form_vocabulary, callback
        return

      @vocabularies_resource.save @form_vocabulary, @vocabularySaved

    addVocabulary: (vocabulary) ->
      index = @vocabularyIndex vocabulary.id

      if index == -1
        @vocabularies.unshift vocabulary
        index = 0

      else
        Vue.set @vocabularies, index, vocabulary

      @vocabularyAdded index, vocabulary

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

    unless @context
      @loadVocabularies()

  watch:
    context:
      immediate: true
      handler: ->
        @vocabularies_resource ?= new VocabulariesResource
        @loadVocabularies()
