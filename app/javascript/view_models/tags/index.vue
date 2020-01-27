<template lang="pug">
.entity-index.tags-index.default-container
  tags-hierarchy(v-if='tags'
                 :parent_tags='tags'
                 @forceReload='forceReload')
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
</script->
