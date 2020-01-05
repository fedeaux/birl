<template lang="pug">
.entity-show-wrapper.tags-show-wrapper.default-container(v-if='tag')
  .entity-show.tags-show
    tags-display(:tag='tag')
      router-link.entity-show-header-actions(:to='tag.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import TagsResource from '../../resources/tags_resource'

export default
  props:
    parent_tag: null

  data: ->
    tag: null
    tag_id: null

  methods:
    loadTag: ->
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
    '$route.params.id':
      immediate: true
      handler: ->
        @tags_resource ?= new TagsResource
        @tag_id = parseInt @$route.params.id
        @loadTag()
</script>
