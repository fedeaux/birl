<template lang="pug">
tags-manager.tags-index(:parent_tags='tags')
</template>

<script lang="coffee">
import TagsResource from '../../resources/tags_resource'

export default
  data: ->
    tags: null

  methods:
    loadTags: ->
      @tags_resource.hierarchy @tagsLoaded

    tagsLoaded: (response) ->
      @tags = response.tags

    forceReload: ->
      @tags = null
      @$nextTick ->
        @loadTags()

  mounted: ->
    @tags_resource = new TagsResource
    @loadTags()
</script>
