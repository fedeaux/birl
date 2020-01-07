<template lang="pug">
.entity-new.tag-taggable-new.default-container
  .entity-display
    .entity-display-main New Tag Taggable

  tag-taggables-form(v-model='tag_taggable'
                     @save='saveTagTaggable'
                     @cancel='back')
</template>

<script lang="coffee">

import TagTaggablesResource from '../../resources/tag_taggables_resource'
import TagTaggable from '../../models/tag_taggable'

export default
  data: ->
    tag_taggable: new TagTaggable

  methods:
    saveTagTaggable: ->
      @tag_taggables_resource.save @tag_taggable, @saved

    saved: (data) ->
      @$router.push data.tag_taggable.path()

    back: ->
      @$router.push @tag_taggable.collectionPath()

  mounted: ->
    @tag_taggables_resource = new TagTaggablesResource
</script>
