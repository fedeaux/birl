<template lang="pug">
.entity-index.tags-index.default-container
  tags-manager(:parent_tags='tags')
</template>

<script lang="coffee">
import TagsResource from '../../resources/tags_resource'

export default
  data: ->
    tags: null

  methods:
    loadTags: ->
      @tags_resource.index @tagsLoaded

    tagsLoaded: (response) ->
      @tags = response.tags

  mounted: ->
    @tags_resource = new TagsResource
    @loadTags()
</script>
