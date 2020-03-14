<template lang="pug">
.tag-taggable-list.flex-column
  .flex-item-fixed
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .flex-item.scroll-y
    .tag-taggables-list-items-wrapper
      tag-taggables-list-item(v-for='tag_taggable in displayable_tag_taggables'
                              v-if='tag_taggables'
                              :tag_taggable='tag_taggable'
                              :allow_actions='allow_actions'
                              :key='tag_taggable.id'
                              @edit='$emit("edit", { tag_taggable: tag_taggable })'
                              @destroy='$emit("destroy", { tag_taggable: tag_taggable })')

      entity-list-empty(v-if='!tag_taggables || tag_taggables.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    tag_taggables:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (tag_taggable) ->
      (@filter.text == '' or tag_taggable.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_tag_taggables: ->
      return [] unless @tag_taggables

      (tag_taggable for tag_taggable in @tag_taggables when @matchFilters tag_taggable)
</script>
