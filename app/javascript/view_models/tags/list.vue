<template lang="pug">
.tag-list.flex-column
  .flex-item-fixed
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .flex-item.scroll-y
    .tags-list-items-wrapper
      tags-list-item(v-for='tag in displayable_tags'
                     v-if='tags'
                     :tag='tag'
                     :allow_actions='allow_actions'
                     :key='tag.id'
                     @edit='$emit("edit", { tag: tag })'
                     @destroy='$emit("destroy", { tag: tag })')

      entity-list-empty(v-if='!tags || tags.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    tags:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (tag) ->
      (@filter.text == '' or tag.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_tags: ->
      return [] unless @tags

      (tag for tag in @tags when @matchFilters tag)
</script>
