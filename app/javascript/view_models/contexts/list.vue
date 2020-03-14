<template lang="pug">
.entity-list.context-list.default-container.flex-column
  .flex-item-fixed
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .flex-item
    contexts-list-item(v-for='context in displayable_contexts'
                       v-if='contexts'
                       :context='context'
                       :allow_actions='allow_actions'
                       :key='context.id'
                       @edit='$emit("edit", { context: context })'
                       @destroy='$emit("destroy", { context: context })')

    entity-list-empty(v-if='!contexts || contexts.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    contexts:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (context) ->
      (@filter.text == '' or context.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_contexts: ->
      return [] unless @contexts

      (context for context in @contexts when @matchFilters context)
</script>
