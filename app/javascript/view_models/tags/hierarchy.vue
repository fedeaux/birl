<template lang="pug">
.entity-hierarchy.tags-hierarchy
  .entity-hierarchy-form(v-if='form_tag && root')
    tags-form(v-model='form_tag'
              @save='saveFormTag()'
              @cancel='clearFormTag()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-tag-button.ui.primary.top.attached.fluid.small.icon.button(@click='newTag' v-if='root')
        i.plus.icon
        |  Add Tag

    tags-hierarchy-item(v-for='tag in tags'
                        :tag='tag'
                        :depth='depth')
</template>

<script lang="coffee">
import TagsManagerMixin from '../../mixins/tags/manager'

export default
  mixins: [TagsManagerMixin]

  props:
    depth:
      default: 0

  computed:
    root: ->
      @depth == 0

  methods:
    onEdit: (data) ->
      @setFormTag data.tag

    onDestroy: (data) ->
      @destroyTag data

    onNew: (data) ->
      @newTag data.tag_attributes

    tagSaved: ->
      @forceReloadTags()

    tagRemoved: ->
      @forceReloadTags()

    forceReloadTags: ->
      @clearFormTag()
      @$emit 'forceReload'

  mounted: ->
    return unless @root
    Global.events.$on 'Tags::Hierarchy::Edit', @onEdit
    Global.events.$on 'Tags::Hierarchy::Destroy', @onDestroy
    Global.events.$on 'Tags::Hierarchy::New', @onNew

  beforeDestroy: ->
    Global.events.$off 'Tags::Hierarchy::Edit', @onEdit
    Global.events.$off 'Tags::Hierarchy::Destroy', @onDestroy
    Global.events.$off 'Tags::Hierarchy::New', @onNew

</script>
