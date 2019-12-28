<template lang="pug">
.entity-edit.vocabulary-edit.default-container
  .entity-display
    .entity-display-main Edit Vocabulary

  vocabularies-form(v-model='vocabulary'
                    v-if='vocabulary'
                    @save='saveVocabulary()'
                    @cancel='vocabularyDone()')
</template>

<script lang="coffee">

import VocabulariesResource from '../../resources/vocabularies_resource'
import Vocabulary from '../../models/vocabulary'

export default
  data: ->
    vocabulary: null

  methods:
    loadVocabulary: ->
      @vocabularies_resource.get @vocabulary_id, @vocabularyLoaded

    vocabularyLoaded: (response) ->
      @vocabulary = response.vocabulary

    saveVocabulary: ->
      @vocabularies_resource.save @vocabulary, @vocabularyDone

    vocabularyDone: ->
      @$router.push @vocabulary.path()

  computed:
    vocabulary_id: ->
      @$route.params.id

  mounted: ->
    @vocabularies_resource = new VocabulariesResource
    @loadVocabulary()
</script>
