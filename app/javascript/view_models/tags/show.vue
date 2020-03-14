<template lang="pug">
.tags-show-wrapper.flex-column.t-padded-2(v-if='tag')
  .tags-show.flex-item-fixed
    tags-display(:tag='tag')
      shared-link.action-text(:to='tag.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
    .flex-item
      memes-stream-index(:context='{ tag_id: tag.id }')
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import TagsResource from '../../resources/tags_resource'

export default
  props:
    parent_tag: null
    tag_id:
      default: null

  data: ->
    tag: null

  methods:
    loadTag: ->
      return unless @tag_id
      @tags_resource.get @tag_id, @tagLoaded

    tagLoaded: (response) ->
      @tag = response.tag

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @tag = @parent_tag if @parent_tag
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    tag_id:
      immediate: true
      handler: ->
        @tags_resource ?= new TagsResource
        @loadTag()
</script>
