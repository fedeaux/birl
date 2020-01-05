<template lang="pug">
.entity-new.tag-new.default-container
  .entity-display
    .entity-display-main New Tag

  tags-form(v-model='tag'
            @save='saveTag'
            @cancel='back')
</template>

<script lang="coffee">

import TagsResource from '../../resources/tags_resource'
import Tag from '../../models/tag'

export default
  data: ->
    tag: new Tag

  methods:
    saveTag: ->
      @tags_resource.save @tag, @saved

    saved: (data) ->
      @$router.push data.tag.path()

    back: ->
      @$router.push @tag.collectionPath()

  mounted: ->
    @tags_resource = new TagsResource
</script>
