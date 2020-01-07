<template lang="pug">
.entity-index.tag-taggables-index.default-container
  tag-taggables-manager(:parent_tag_taggables='tag_taggables')
</template>

<script lang="coffee">
import TagTaggablesResource from '../../resources/tag_taggables_resource'

export default
  data: ->
    tag_taggables: null

  methods:
    loadTagTaggables: ->
      @tag_taggables_resource.index @tagTaggablesLoaded

    tagTaggablesLoaded: (response) ->
      @tag_taggables = response.tag_taggables

  mounted: ->
    @tag_taggables_resource = new TagTaggablesResource
    @loadTagTaggables()
</script>
