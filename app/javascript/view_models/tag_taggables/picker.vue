<template lang="pug">
  .tag-taggables-picker
    //- shared-modal(v-if='form_tag_taggable' title='New Tag Taggable')
    //-   tag-taggables-form(v-model='form_tag_taggable'
    //-                  @save='saveFormTagTaggable()'
    //-                  @cancel='clearFormTagTaggable()')
    template(v-for='tag in tags')
      .tag-taggables-picker-item(@click='toogleSelectedTag(tag)')
        tags-tag(:tag='tag' display='fullname')
          template(v-if='isSelected(tag)')
            | &nbsp;
            | &nbsp;
            i.checkmark.icon

</template>

<script lang="coffee">
import TagsManagerMixin from '../../mixins/tags/manager'

export default
  mixins: [TagsManagerMixin]

  model:
    prop: 'selected_tags'

  props:
    taggable_id:
      default: null

    taggable_type:
      default: true

    selected_tags:
      default: -> []

  data: ->
    selected_tags_ids: []

  methods:
    isSelected: (tag) ->
      @selected_tags_ids.indexOf(tag.id) != -1

    toogleSelectedTag: (tag) ->
      index = @selected_tags_ids.indexOf tag.id

      if index == -1
        @selected_tags_ids.push tag.id

      else
        @selected_tags_ids.splice index, 1

      @$emit 'input', @selectedTags()

    selectedTags: ->
      (@getTag(tag_id) for tag_id in @selected_tags_ids)

  watch:
    selected_tags:
      immediate: true
      deep: true
      handler: ->
        if @selected_tags
          @selected_tags_ids = (tag.id for tag in @selected_tags)
          return

        @selected_tags_ids = []

</script>
