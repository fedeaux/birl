<template lang="pug">
.entity-index.vocabularies-index.default-container
  vocabularies-manager(:parent_vocabularies='vocabularies')
</template>

<script lang="coffee">
import VocabulariesResource from '../../resources/vocabularies_resource'

export default
  data: ->
    vocabularies: null

  methods:
    loadVocabularies: ->
      @vocabularies_resource.index @vocabulariesLoaded

    vocabulariesLoaded: (response) ->
      @vocabularies = response.vocabularies

  mounted: ->
    @vocabularies_resource = new VocabulariesResource
    @loadVocabularies()
</script>
