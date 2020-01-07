<template lang="pug">
.entity-show-wrapper.tag-taggables-show-wrapper.default-container(v-if='tag_taggable')
  .entity-show.tag-taggables-show
    tag-taggables-display(:tag_taggable='tag_taggable')
      router-link.entity-show-header-actions(:to='tag_taggable.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import TagTaggablesResource from '../../resources/tag_taggables_resource'

export default
  props:
    parent_tag_taggable: null

  data: ->
    tag_taggable: null
    tag_taggable_id: null

  methods:
    loadTagTaggable: ->
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
    '$route.params.id':
      immediate: true
      handler: ->
        @tag_taggables_resource ?= new TagTaggablesResource
        @tag_taggable_id = parseInt @$route.params.id
        @loadTagTaggable()
</script>
