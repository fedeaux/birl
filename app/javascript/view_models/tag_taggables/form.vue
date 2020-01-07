<template lang="pug">
.entity-form-wrapper.tag-taggables-form-wrapper.default-container(v-if='tag_taggable')
  .entity-form.tag-taggables-form
    .ui.form
      .field
        label Taggable
        taggables-select(v-model='tag_taggable.taggable_id')

      .field
        label Tag
        tags-select(v-model='tag_taggable.tag_id')

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import TagTaggablesResource from '../../resources/tag_taggables_resource'
import TagTaggable from '../../models/tag_taggable'

export default
  model:
    prop: 'original_tag_taggable'

  props:
    original_tag_taggable: null

  data: ->
    tag_taggable: null

  methods:
    save: ->
      @$emit 'input', @tag_taggable
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_tag_taggable:
      immediate: true
      deep: true
      handler: ->
        if @original_tag_taggable
          @tag_taggable = @original_tag_taggable.clone()
        else
          @tag_taggable = null
</script>
