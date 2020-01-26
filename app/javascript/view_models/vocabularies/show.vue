<template lang="pug">
.entity-show-wrapper.vocabularies-show-wrapper.default-container(v-if='vocabulary')
  .entity-show.vocabularies-show
    vocabularies-display(:vocabulary='vocabulary')
      router-link.entity-show-header-actions(:to='vocabulary.editPath()')
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
