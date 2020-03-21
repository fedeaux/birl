<template lang="pug">
.entity-hierarchy.flex-column
  .flex-item.grow-0(v-if='form_tag && root')
    tags-form(v-model='form_tag'
              @save='saveFormTag()'
              @cancel='clearFormTag()')

  .flex-column(v-else)
    .flex-item-fixed.action-block.b-padded-1(v-if='root')
      .ui.primary.action-block-button.small.icon.button(@click='newTag')
        i.plus.icon
        |  Add Tag

    .flex-column.scroll-y
      .flex-column
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
