<template lang="pug">
.entity-new.vocabulary-new.default-container
  .entity-display
    .entity-display-main New Vocabulary

  vocabularies-form(v-model='vocabulary'
                    @save='saveVocabulary'
                    @cancel='back')
</template>

<script lang="coffee">

import VocabulariesResource from '../../resources/vocabularies_resource'
import Vocabulary from '../../models/vocabulary'

export default
  data: ->
    vocabulary: new Vocabulary

  methods:
    saveVocabulary: ->
      @vocabularies_resource.save @vocabulary, @saved

    saved: (data) ->
      @$router.push data.vocabulary.path()

    back: ->
      @$router.push @vocabulary.collectionPath()

  mounted: ->
    @vocabularies_resource = new VocabulariesResource
</script>
