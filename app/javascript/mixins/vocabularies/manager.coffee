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
    add_new: 'before'

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
      @vocabularies_resource ?= new VocabulariesResource

      if @parent_vocabularies
        @vocabulariesLoaded vocabularies: @parent_vocabularies
        return

      @vocabularies_resource.index @vocabulariesLoaded, @context

    vocabulariesLoaded: (response) ->
      @vocabularies = response.vocabularies

    buildVocabulary: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      new Vocabulary final_params

    newVocabulary: (params = {}) ->
      @setFormVocabulary @buildVocabulary params

    setFormVocabulary: (@form_vocabulary) ->
      @form_vocabulary

    clearFormVocabulary: ->
      @setFormVocabulary null

    vocabularyIndex: (vocabulary_id) ->
      for index, vocabulary of @vocabularies
        return index if vocabulary.id == vocabulary_id

      -1

    saveVocabulary: (vocabulary, custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @vocabularySaved(data)
          custom_callback(data)

        @vocabularies_resource.save vocabulary, callback
        return

      @vocabularies_resource.save vocabulary, @vocabularySaved

    saveFormVocabulary: (custom_callback = false) ->
      @saveVocabulary @form_vocabulary, custom_callback

    createVocabulary: (attributes, custom_callback = false) ->
      @saveVocabulary @buildVocabulary(attributes), custom_callback

    addVocabulary: (vocabulary) ->
      index = @vocabularyIndex vocabulary.id

      if index == -1
        if @add_new == 'before'
          @vocabularies.unshift vocabulary
          index = 0
        else
          @vocabularies.push vocabulary
          index = @vocabularies.length - 1

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

  watch:
    context:
      immediate: true
      handler: ->
        @loadVocabularies()
