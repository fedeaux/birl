<template lang="pug">
  sui-dropdown(:options='vocabularies_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               placeholder='Vocabulary'
               v-model='selected_vocabulary_id')
</template>

<script lang="coffee">
import VocabulariesResource from '../../resources/vocabularies_resource'

export default
  model:
    prop: 'vocabulary_id'

  props:
    vocabulary_id: null

  data: ->
    vocabularies: null
    selected_vocabulary_id: null

  methods:
    loadVocabularies: ->
      @vocabularies_resource.index @vocabulariesLoaded

    vocabulariesLoaded: (response) ->
      @vocabularies = response.vocabularies

    vocabularyIndex: (vocabulary_id) ->
      for index, vocabulary of @vocabularies
        return index if vocabulary.id == vocabulary_id

      -1

    getVocabulary: (vocabulary_id) ->
      index = @vocabularyIndex vocabulary_id
      return null if index == -1
      @vocabularies[index]

  computed:
    loading: ->
      !@vocabularies

    vocabularies_as_options: ->
      return [] unless @vocabularies
      { key: vocabulary.id, value: vocabulary.id, text: vocabulary.name } for vocabulary in @vocabularies

  watch:
    selected_vocabulary_id: ->
      @$emit 'input', @selected_vocabulary_id

    vocabulary_id:
      immediate: true
      handler: ->
        return unless @vocabulary_id
        @selected_vocabulary_id = parseInt @vocabulary_id

  mounted: ->
    @vocabularies_resource = new VocabulariesResource
    @loadVocabularies()

</script>
