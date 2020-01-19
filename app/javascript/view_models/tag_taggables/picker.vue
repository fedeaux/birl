<template lang="pug">
  .tag-taggables-picker
    .tag-taggables-picker-item(v-for='tag in tags' @click='toogleSelectedTag(tag)')
      tags-tag(:tag='tag' display='fullname')
        template(v-if='isSelected(tag)')
          | &nbsp;
          | &nbsp;
          i.checkmark.icon

</template>

<script lang="coffee">
import TagsManagerMixin from '../../mixins/tags/manager'
import TagsResource from '../../resources/tags_resource'

export default
  mixins: [TagsManagerMixin]

  model:
    prop: 'selected_tags'

  props:
    taggable_id:
      default: null

    taggable_type:
      default: true

    selected_tags:
      default: -> []

  data: ->
    selected_tags_ids: []

  methods:
    loadTags: ->
      @tags_resource ?= new TagsResource

      if @parent_tags
        @tagsLoaded tags: @parent_tags
        return

      @tags_resource.leaves @tagsLoaded, @context

    isSelected: (tag) ->
      @selected_tags_ids.indexOf(tag.id) != -1

    toogleSelectedTag: (tag) ->
      index = @selected_tags_ids.indexOf tag.id

      if index == -1
        @selected_tags_ids.push tag.id

      else
        @selected_tags_ids.splice index, 1

      @$emit 'input', @selectedTags()

    selectedTags: ->
      (@getTag(tag_id) for tag_id in @selected_tags_ids)

  watch:
    selected_tags:
      immediate: true
      deep: true
      handler: ->
        if @selected_tags
          @selected_tags_ids = (tag.id for tag in @selected_tags)
          return

        @selected_tags_ids = []

</script>
