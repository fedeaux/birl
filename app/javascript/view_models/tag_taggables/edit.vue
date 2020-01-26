<template lang="pug">
.entity-edit.tag_taggable-edit.default-container
  .entity-display
    .entity-display-main Edit Tag Taggable

  tag-taggables-form(v-model='tag_taggable'
                     v-if='tag_taggable'
                     @save='saveTagTaggable()'
                     @cancel='tagTaggableDone()')
</template>

<script lang="coffee">

import TagTaggablesResource from '../../resources/tag_taggables_resource'
import TagTaggable from '../../models/tag_taggable'

export default
  props:
    tag_taggable_id:
      default: null

  data: ->
    tag_taggable: null

  methods:
    loadTagTaggable: ->
      @tag_taggables_resource.get @tag_taggable_id, @tagTaggableLoaded

    tagTaggableLoaded: (response) ->
      @tag_taggable = response.tag_taggable

    saveTagTaggable: ->
      @tag_taggables_resource.save @tag_taggable, @tagTaggableDone

    tagTaggableDone: ->
      @$router.push @tag_taggable.path()

  mounted: ->
    @tag_taggables_resource = new TagTaggablesResource
    @loadTagTaggable()
</script>
