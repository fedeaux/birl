<template lang="pug">
.tag-taggables-show-wrapper.flex-column.t-padded-2(v-if='tag_taggable')
  .tag-taggables-show.flex-item-fixed
    tag-taggables-display(:tag_taggable='tag_taggable')
      shared-link.action-text(:to='tag_taggable.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import TagTaggablesResource from '../../resources/tag_taggables_resource'

export default
  props:
    parent_tag_taggable: null
    tag_taggable_id:
      default: null

  data: ->
    tag_taggable: null

  methods:
    loadTagTaggable: ->
      return unless @tag_taggable_id
      @tag_taggables_resource.get @tag_taggable_id, @tagTaggableLoaded

    tagTaggableLoaded: (response) ->
      @tag_taggable = response.tag_taggable

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @tag_taggable = @parent_tag_taggable if @parent_tag_taggable
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    tag_taggable_id:
      immediate: true
      handler: ->
        @tag_taggables_resource ?= new TagTaggablesResource
        @loadTagTaggable()
</script>
