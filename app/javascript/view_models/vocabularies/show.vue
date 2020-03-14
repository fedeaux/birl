<template lang="pug">
.vocabularies-show-wrapper.flex-column.t-padded-2(v-if='vocabulary')
  .vocabularies-show.flex-item-fixed
    vocabularies-display(:vocabulary='vocabulary')
      shared-link.action-text(:to='vocabulary.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import VocabulariesResource from '../../resources/vocabularies_resource'

export default
  props:
    parent_vocabulary: null
    vocabulary_id:
      default: null

  data: ->
    vocabulary: null

  methods:
    loadVocabulary: ->
      return unless @vocabulary_id
      @vocabularies_resource.get @vocabulary_id, @vocabularyLoaded

    vocabularyLoaded: (response) ->
      @vocabulary = response.vocabulary

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @vocabulary = @parent_vocabulary if @parent_vocabulary
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    vocabulary_id:
      immediate: true
      handler: ->
        @vocabularies_resource ?= new VocabulariesResource
        @loadVocabulary()
</script>
