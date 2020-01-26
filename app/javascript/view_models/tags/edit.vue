<template lang="pug">
.entity-edit.tag-edit.default-container
  .entity-display
    .entity-display-main Edit Tag

  tags-form(v-model='tag'
            v-if='tag'
            @save='saveTag()'
            @cancel='tagDone()')
</template>

<script lang="coffee">

import TagsResource from '../../resources/tags_resource'
import Tag from '../../models/tag'

export default
  data: ->
    tag: null
    tag_id:
      default: null

  methods:
    loadTag: ->
      @tags_resource.get @tag_id, @tagLoaded

    tagLoaded: (response) ->
      @tag = response.tag

    saveTag: ->
      @tags_resource.save @tag, @tagDone

    tagDone: ->
      @$router.push @tag.path()

  mounted: ->
    @tags_resource = new TagsResource
    @loadTag()
</script>
