<template lang="pug">
  shared-modal(v-if='form_vocabulary' title='New Vocabulary')
    vocabularies-form(v-model='form_vocabulary'
                   @save='saveFormVocabulary()'
                   @cancel='clearFormVocabulary()')

  sui-dropdown(:options='vocabularies_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Vocabulary'
               v-else
               v-model='selected_vocabulary_id')

</template>

<script lang="coffee">
import VocabulariesManagerMixin from '../../mixins/vocabularies/manager'

export default
  mixins: [VocabulariesManagerMixin]

  model:
    prop: 'vocabulary_id'

  props:
    vocabulary_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_vocabulary_id: null

  methods:
    vocabularyAdded: (index, vocabulary) ->
      @selectVocabulary vocabulary

    selectVocabulary: (vocabulary) ->
      @selected_vocabulary_id = parseInt vocabulary.id

  computed:
    loading: ->
      !@vocabularies

    vocabularies_as_options: ->
      return [] unless @vocabularies
      { key: vocabulary.id, value: vocabulary.id, text: vocabulary.name } for vocabulary in @vocabularies

  watch:
    selected_vocabulary_id: ->
      selected_vocabulary_id = parseInt @selected_vocabulary_id

      unless isNaN selected_vocabulary_id
        @$emit 'input', selected_vocabulary_id
        return

      @newVocabulary name: @selected_vocabulary_id

    vocabulary_id:
      immediate: true
      handler: ->
        return unless @vocabulary_id
        @selected_vocabulary_id = parseInt @vocabulary_id

</script>
