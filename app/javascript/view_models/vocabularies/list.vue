<template lang="pug">
.entity-list.vocabulary-list.default-container
  .entity-list-filter
    inputs-clearable.fluid(v-model='filter.text')

  vocabularies-list-item(v-for='vocabulary in displayable_vocabularies'
                         v-if='vocabularies'
                         :vocabulary='vocabulary'
                         :allow_actions='allow_actions'
                         :key='vocabulary.id'
                         @edit='$emit("edit", { vocabulary: vocabulary })'
                         @destroy='$emit("destroy", { vocabulary: vocabulary })')

  entity-list-empty(v-if='!vocabularies || vocabularies.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    vocabularies:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (vocabulary) ->
      return true if @filter.text == ''

      for word in [vocabulary.pt_br, vocabulary.es, vocabulary.en]
        continue unless word
        return true if word.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1

  computed:
    displayable_vocabularies: ->
      return [] unless @vocabularies

      (vocabulary for vocabulary in @vocabularies when @matchFilters vocabulary)
</script>
